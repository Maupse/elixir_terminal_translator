defmodule ElixirTerminalTranslator.Translator.Google do
  @base_url "https://translation.googleapis.com/language/translate/v2"
  @url ""
  @name "google"

  @spec client() :: {:ok, Tesla.Client.t()} | {:error, String.t()}
  def client() do
    case ElixirTerminalTranslator.Translator.Config.get_key(@name) do
      {:ok, key} ->
        client = Tesla.client([
          {Tesla.Middleware.BaseUrl, @base_url},
          Tesla.Middleware.JSON,
          {Tesla.Middleware.Query, key: key}
        ])
        {:ok, client}
      {:error, message} -> {:error, message}
    end
  end

  def url, do: @url

  def body(source, target, text) do
    source = if source == "auto", do: ""
    %{
      q: text,
      source: source,
      target: target,
      format: "text"
    }
  end

  @spec extract(map()) :: {:ok, String.t()} | {:error, String.t()}
  def extract(response_body) do
    case response_body do
      %{"data" => %{"translations" => [%{"translatedText" => text}]}} -> {:ok, text}
      _ -> {:error, "Response body does not match the google specifics"}
    end
  end

end
