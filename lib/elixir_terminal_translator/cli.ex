defmodule ElixirTerminalTranslator.CLI do
  import ElixirTerminalTranslator.Options

  def main(args) do

    {parsed, args, invalid} = OptionParser.parse(args, aliases: aliases(), strict: options())

    {help_active, parsed_without_help} = Keyword.pop(parsed, :help, default: :false)

    if help_active do
      ElixirTerminalTranslator.Help.help(parsed_without_help, args, invalid)
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
      case e do
        {option_name, nil} -> warning("#{option_name} is not a valid flag")

        {option_name, value} ->
          atom = to_atom(option_name)
          val_type = options()[atom]
          warning("Incorrect type: Expected #{option_name} <#{val_type}> but got `#{value}`")
      end
    end
    info("Use --help <your_options> for more information! \n")
  end

  defp warning(text) do
    IO.ANSI.format([:yellow,  "WARNING! #{text}"])
    |> IO.puts()
  end

  defp info(text) do
    IO.ANSI.format([:light_magenta, "INFO! #{text}"])
    |> IO.puts()
  end
end
