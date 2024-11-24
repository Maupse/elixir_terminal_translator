defmodule ElixirTerminalTranslator.CLI do
  import ElixirTerminalTranslator.Options, only: [aliases: 0, options: 0]

  def main(args) do

    {parsed, args, invalid} = OptionParser.parse(args, aliases: aliases(), strict: options())
    IO.inspect(parsed)
    IO.inspect(args)
    IO.inspect(invalid)


    if Keyword.has_key?(parsed, :help) do
      ElixirTerminalTranslator.Help.help(parsed, args, invalid)
    else
      warn_invalid(invalid)
      ElixirTerminalTranslator.Translator.translate(args, parsed)
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

  def info(text) do
    IO.ANSI.format([:light_magenta, "INFO! #{text}"])
    |> IO.puts()
  end

  def help_info(text) do
    IO.ANSI.format([:green, "HELP! #{text}"])
    |> IO.puts()
  end
end
