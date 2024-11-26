defmodule ElixirTerminalTranslator.Translator do
alias ElixirTerminalTranslator.Translator.Config, as: Config
alias ElixirTerminalTranslator.Translator.Codes, as: Codes
import ElixirTerminalTranslator.CLI, only: [error: 1, info: 1, translation_info: 1]

  @spec translate(String.t(), Keyword.t()) :: :ok | :error | :nil
  def translate(text, opts) do
    with {:ok, config} <- Config.load_config(),
      config <- update_config(config, opts),
      :ok <- parse_configuration(config),
      :ok <- check_text(text),
      {:ok, translation} <- request_translation(config.translator, config.in, config.out, text)
    do process_translation(config, translation)
    else
      {:error, reason} -> error(reason)
      {:info, message} -> info(message)
    end
  end

  defp update_config(config, opts) do
    Map.merge(config, Enum.into(opts, %{}), fn _k, _v1, v2 -> v2 end)
  end

  @spec check_text(String.t()) :: :ok | {:info, String.t()}
  defp check_text(text) do
    if text == "" do
      {:info, "No text to translate"}
    else
      :ok
    end
  end

 @spec parse_configuration(map()) :: :ok | {:error, String.t()}
 def parse_configuration(config) do
  IO.puts("Parse config #{inspect(config)}")

  if Map.has_key?(config, :version) and config.version == true do
    version = Application.spec(:elixir_terminal_translator, :vsn) |> to_string()
    IO.puts("Version: #{version}")
  end

  :ok
 end

  alias ElixirTerminalTranslator.Translator.Google, as: Google
  @translators %{
    "google" => %{client: &Google.client/0, url: &Google.url/0, body: &Google.body/3, extract: &Google.extract/1}
  }

  def request_translation(translator, inp, out, text) do
    with %{client: client, url: url, body: body, extract: extract} <- @translators[translator],
      {:ok, cli} <- client.(), # This also checks the key
      {source, target} <- Codes.transform_if_alias({inp, out}),
      :ok <- Codes.check_code_configuration(translator, {source, target}),
      {:ok, %{status: 200, body: response_body}} <- Tesla.post(cli, url.(), body.(source, target, text)),
      {:ok, translated} <- extract.(response_body)
    do {:ok, translated}
    else
      nil -> {:error, "Invalid translator, expected #{inspect(Map.keys(@translators))}"}
      {:error, message} when is_binary(message) -> {:error, message}
      {:ok, %{status: code, body: %{"error" => %{"message" => message}}}} -> {:error, "#{translator} API error: #{code} - #{message}"}
      {:ok, %{status: status, body: body}} -> {:error, "#{translator} API error: #{status} - #{inspect(body)}"}
      {:error, error} -> {:error, "Request failed: #{inspect(error)}"}
    end
  end

  @spec process_translation(map(), String.t()) :: :ok | :error
  defp process_translation(config, text) do
    if Map.has_key?(config, :path) do
      info("Writing to path")
      case write_to_path(config.path, config.out, text) do
        :ok -> :ok
        {:error, message} -> error(message)
          :error
      end
    else
      translation_info(text)
    end
  end

  @spec write_to_path(IO.chardata(), String.t(), String.t()) :: :ok | {:error, String.t()}
  defp write_to_path(path, out, text) do
    if not File.dir?(path) do
      File.mkdir_p!(path)
    end
    path = Path.join(path, "translation_#{out}.txt")

    case File.write(path, text) do
      :ok -> :ok
      {:error, posix} -> {:error, "Writing output file to #{path} failed because: #{inspect(posix)}"}
    end
  end

end
