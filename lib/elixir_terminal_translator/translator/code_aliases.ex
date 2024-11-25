defmodule ElixirTerminalTranslator.Translator.CodeAliases do
  @external_resource_aliases "compile_time_assets/code_aliases.txt"
  @aliases_map File.read!(@external_resource_aliases)
                |> String.split("\n", trim: true)
                |> Enum.map(&String.split(&1, ":", trim: true))
                |> Map.new(fn [k, v] -> {k, String.replace(v, [" ", "\r"], "")} end)

end
