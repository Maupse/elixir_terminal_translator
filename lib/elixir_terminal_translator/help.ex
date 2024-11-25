defmodule ElixirTerminalTranslator.Help do
import ElixirTerminalTranslator.Options
import ElixirTerminalTranslator.CLI, only: [warning: 1, help_info: 1]
  def help([{:help, true}], "", []) do
    overview()
  end

  @spec help(Keyword.t(), String.t(), Keyword.t()) :: nil
  def help(opts, text, invalid_opts) do
    for option <- opts do
      explain_option(option)
    end
    for option <- invalid_opts do
      explain_invalid_option(option)
    end
    if text != [] do
      explain_text(text)
    end
  end

  def overview() do
    IO.puts("Overview")
  end

  defp explain_text(text) do
    IO.puts("explain text #{text}")
  end


  def explain_option({opt_atom, val}) do
    explanation = explanation(opt_atom)
    help_info("#{opt_atom} #{val}: #{explanation}")
  end


  def explain_invalid_option({opt_string, nil}) do
    opt_atom = to_atom(opt_string)

    key = if Keyword.has_key?(aliases(), opt_atom) do
      aliases()[opt_atom]
    else
      opt_atom
    end

    if Keyword.has_key?(options(), key) do
      explain_option({key, "nil"})
      value_mismatch(opt_string, options()[key])
    else
      boolean_flag_invalid(opt_string)
    end
  end

  def explain_invalid_option({opt_string, value}) do
    opt_atom = to_atom(opt_string)
    value_mismatch(opt_string, options()[opt_atom], value)
  end

  defp boolean_flag_invalid(opt_string) do
    warning("#{opt_string} is invalid, because it does not exist.")
  end

  defp value_mismatch(opt_string, value_type, val \\ nil) do
    warning("Expected type #{value_type} for #{opt_string} but found value #{inspect(val)}.")
  end

end
