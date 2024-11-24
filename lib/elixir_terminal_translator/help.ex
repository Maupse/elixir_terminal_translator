defmodule ElixirTerminalTranslator.Help do

  def help([], [], []) do
    overview()
  end

  def help(opts, args, invalid_opts) do
    for option <- opts do
      explain_option(option)
    end
    for option <- invalid_opts do
      explain_invalid_option(option)
    end
    if args != [] do
      explain_args(args)
    end
  end

  def overview() do

  end

  defp explain_args(args) do

  end


  def explain_option(option) do

  end

  def explain_invalid_option(option) do

  end

end
