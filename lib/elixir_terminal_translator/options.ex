defmodule ElixirTerminalTranslator.Options do

  @options [
      help: :boolean,
      lang: :integer,
  ]

  @aliases [
    h: :help,

  ]

  def options do
    @options
  end

  def aliases do
    @aliases
  end

  def to_atom(option) when is_binary(option) do
    option
    |> String.trim_leading("--")
    |> String.replace("-", "_")
    |> String.to_atom()
  end
end
