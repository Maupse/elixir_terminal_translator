defmodule ElixirTerminalTranslator.Translator do
import ElixirTerminalTranslator.Translator.Config, only: [load_config: 0]
import ElixirTerminalTranslator.CLI, only: [error: 1]

  @spec translate(String.t(), Keyword.t()) :: nil
  def translate(text, opts) do
    with {:ok, config} <- load_config(),
      config <- Map.merge(config, Enum.into(opts, %{}), fn _k, _v1, v2 -> v2 end)
    do parse_configuration(config)

      if text != "" do
        case get_translation(config, text) do
          {:ok, translation} -> process_translation(config, translation)
          {:error, reason} -> error(reason)
        end
      end

    else
      {:error, reason} -> error(reason)
    end
  end

 def parse_configuration(config) do
  IO.puts("Parese config #{inspect(config)}")
 end

 @spec get_translation(map(), String.t()) :: {:ok, String.t()} | {:error, String.t()}
 def get_translation(config, text) do
    case config.translator do
      "google" -> ElixirTerminalTranslator.Translator.Google.translate(config.in_lang, config.out_lang, text)
      "deepl" -> ElixirTerminalTranslator.Translator.Deepl.translate(config.in_lang, config.out_lang, text)
      unknown ->
        error("You chose an invalid translator: #{unknown}, for more information type --help --translator")
        {:error, "invalid translator"}
    end
  end

  @spec process_translation(map(), String.t()) :: :ok | :error
  defp process_translation(config, text) do

  end

end
