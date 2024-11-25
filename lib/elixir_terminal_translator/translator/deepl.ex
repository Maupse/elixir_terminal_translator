defmodule ElixirTerminalTranslator.Translator.Deepl do

  @base_url "https://api-free.deepl.com/v2"
  @key_name "deepl"


  @external_resource_deepl "compile_time_assets/deepl_supported_codes.txt"
  @deepl_codes File.read!(@external_resource_deepl)
                |> String.split("\n", trim: true)
                |> Enum.map(&String.trim_trailing(&1, "\r"))
                |> MapSet.new()
  @spec translate(String.t(), String.t(), String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def translate(in_lang, out_lang, text) do
    IO.puts("DeepL translator")
    IO.puts("in_lang: #{in_lang} out_lang: #{out_lang} text: #{text}")

    case ElixirTerminalTranslator.Translator.Config.get_key(@key_name) do
      {:ok, api_key} ->
        client = Tesla.client([
          {Tesla.Middleware.BaseUrl, @base_url},
          Tesla.Middleware.JSON,
          {Tesla.Middleware.Headers, [{"Authorization", "DeepL-Auth-Key #{api_key}"}]}
         ])

        body = {
          :form,
          [
            {"text", text},
            {"source_lang", String.upcase(in_lang)},
            {"target_lang", String.upcase(out_lang)}
          ]
        }

        case Tesla.post(client, "/translate", body) do
          {:ok, %{status: 200, body: body}} -> {:ok, extract_translation(body)}
          {:ok, %{status: status, body: body}} -> {:error, "Deepl API error: #{status} - #{inspect(body)}"}
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
