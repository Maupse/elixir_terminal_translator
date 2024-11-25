defmodule ElixirTerminalTranslator.Translator.Google do
  @base_url "https://translation.googleapis.com/language/translate/v2"
  @key_name "google"

  @external_resource_google "compile_time_assets/google_supported_codes.txt"
  @google_codes File.read!(@external_resource_google)
                |> String.split(",", trim: true)
                |> Enum.map(&String.replace(&1, [" ", "\n", "\r"], ""))
                |> MapSet.new()

  @spec translate(String.t(), String.t(), String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def translate(in_lang, out_lang, text) do
    IO.puts("Google translator")
    IO.puts("in_lang: #{in_lang} out_lang: #{out_lang} text: #{text}")

    case ElixirTerminalTranslator.Translator.Config.get_key(@key_name) do
      {:ok, api_key} ->
       client = Tesla.client([
        {Tesla.Middleware.BaseUrl, @base_url},
        Tesla.Middleware.JSON,
        {Tesla.Middleware.Query, key: api_key}
       ])

        body = %{
          q: text,
          source: in_lang,
          target: out_lang
        }

        case Tesla.post(client, "", body) do
          {:ok, %{status: 200, body: body}} -> {:ok, extract_translation(body)}
          {:ok, %{status: 400, body: %{"error" => %{"message" => message}}}} -> {:error, "#{message}"}
          {:ok, %{status: status, body: body}} -> {:error, "Google API error: #{status} - #{inspect(body)}"}
          {:error, error} -> {:error, "Request failed: #{inspect(error)}"}
        end

      {:error, message} -> {:error, message}
    end
  end

  @spec extract_translation(any()) :: String.t()
  def extract_translation(response_body) do
    %{"data" => %{"translations" => [%{"translatetText" => text}]}} = response_body
    text
  end
end
