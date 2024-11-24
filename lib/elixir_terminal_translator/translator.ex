defmodule ElixirTerminalTranslator.Translator do

 def translate(text, []) do
  IO.puts("Translate default #{inspect(text)}")
 end

 def translate(text, opts) do
  IO.puts("Translate text #{inspect(text)} with options #{inspect(opts)}")
 end
end
