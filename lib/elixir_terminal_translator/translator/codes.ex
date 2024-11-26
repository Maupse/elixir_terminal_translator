defmodule ElixirTerminalTranslator.Translator.Codes do
  @external_resource_aliases "compile_time_assets/code_aliases.txt"
  @aliases_map File.read!(@external_resource_aliases)
                |> String.split("\n", trim: true)
                |> Enum.map(&String.split(&1, ":", trim: true))
                |> Map.new(fn [k, v] -> {k, String.replace(v, [" ", "\r"], "")} end)

  @external_resource_deepl "compile_time_assets/deepl_supported_codes.txt"
  @deepl_codes File.read!(@external_resource_deepl)
                |> String.split("\n", trim: true)
                |> Enum.map(&String.trim_trailing(&1, "\r"))
                |> MapSet.new()

  @external_resource_google "compile_time_assets/google_supported_codes.txt"
  @google_codes File.read!(@external_resource_google)
                |> String.split(",", trim: true)
                |> Enum.map(&String.replace(&1, [" ", "\n", "\r"], ""))
                |> MapSet.new()

  @spec transform_if_alias(String.t()) :: String.t()
  def transform_if_alias(code) when is_binary(code) do
    case Map.get(@aliases_map, code) do
      nil -> code
      transformed -> transformed
    end
  end

  @spec transform_if_alias({String.t(), String.t()}) :: {String.t(), String.t()}
  def transform_if_alias({in_lang, out_lang}) do
    {transform_if_alias(in_lang), transform_if_alias(out_lang)}
  end

  @spec supported?(String.t(), String.t()) :: boolean()
  def supported?(translator, code) when is_binary(code) do
    set = case translator do
      "google" -> @google_codes
      "deepl" -> @deepl_codes
    end
    MapSet.member?(set, code)
  end

  @spec check_code_configuration(String.t(), {String.t(), String.t()}) :: :ok | {:error, String.t()}
  def check_code_configuration(translator, {in_lang, out_lang}) do
    case {supported?(translator, in_lang) or in_lang == "auto", supported?(translator, out_lang)} do
      {true, true} -> :ok
      {false, false} -> {:error, "Your codes in_lang: #{in_lang}, out_lang: #{out_lang} are either wrong or not supported by the translator"}
      {true, false} -> {:error, "Your out_lang code #{out_lang} is not supported"}
      {false, true} -> {:error, "Your in_lang code #{in_lang} is not supported"}
    end
  end

end
