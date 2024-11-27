defmodule ElixirTerminalTranslator.CLI do
  import ElixirTerminalTranslator.Options, only: [aliases: 0, options: 0]

  @spec fast_syntax(Enum.t()) :: Enum.t()
  defp fast_syntax(args) do
    args = case length(args) do
      0 -> args
      1 ->
        [head | tail] = args
        case head do
          ":" <> rest -> ["--out", rest] ++ tail
          _ -> args
        end
      _ ->
        [head1 | tail1] = args
        [head2 | tail2] = tail1
        case {head1, head2} do
          {":" <> rest1, ":" <> rest2} -> ["--out", rest1, "--in", rest2] ++ tail2
          {":" <> rest, _} -> ["--out", rest] ++ tail1
          _ -> args
        end
    end
    args
  end

  def main(args) do
    args = fast_syntax(args)

    {parsed, args, invalid} = OptionParser.parse_head(args, aliases: aliases(), strict: options())

    text = Enum.join(args, " ")

    if Keyword.has_key?(parsed, :help) do
      ElixirTerminalTranslator.Help.help(parsed, text, invalid)
    else
      warn_invalid(invalid)
      ElixirTerminalTranslator.Translator.translate(text, parsed)
    end
  end

  defp warn_invalid([]) do
    # Do nothing
  end

  defp warn_invalid(invalid_opts) do
    for e <- invalid_opts do
      ElixirTerminalTranslator.Help.explain_invalid_option(e)
    end
    info("Use --help <your_options> for more information! \n")
  end

  def warning(text) do
    IO.ANSI.format([:yellow,  "WARNING! #{text}"])
    |> IO.puts()
  end

  def error(reason) do
    IO.ANSI.format([:red,  "ERROR! #{inspect(reason)}"])
    |> IO.puts()
  end

  def info(text) do
    IO.ANSI.format([:light_magenta, "INFO! #{text}"])
    |> IO.puts()
  end

  def response(text) do
    IO.ANSI.format([:blue, "Response! #{text}"])
    |> IO.puts()
  end

  def help_info(text) do
    IO.ANSI.format([:green, "HELP! #{text}"])
    |> IO.puts()
  end

  def translation_info(text) do
    IO.ANSI.format([:green, "TRANSLATION!\n", :reset, "#{text}"])
    |> IO.puts()
  end
end
