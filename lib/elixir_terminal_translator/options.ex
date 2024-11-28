defmodule ElixirTerminalTranslator.Options do

  @options [
    help: :boolean,
    version: :boolean,
    path: :string,
    in: :string,
    out: :string,
    translator: :string,
    set_api_key: :string,
  ]

  @explanations %{
    help: "--help, -h Boolean flag, explains every option and argument given, if there are no arguments explains everything",
    version: "--version, -v Boolean flag, prints out the version of the program",
    path: "--path, -p <path/to/out_dir> The directory where the translated file goes, will be named translation_<Iso-639-letters>",
    in: "--in, -i <ISO-639-two-letter-language-code> sets the input language for the translator \n Example: -i en for english",
    out: "--out, -o <ISO-639-two-letter-language-code> sets the output language for the translator \n Example: -o de for german",
    set_api_key: "--set-api-key, -s <API-KEY>, sets API key for the current translator",
    translator: "--translator, -t google | deepl sets the translator you want to translate with"
  }

  @aliases [
    h: :help,
    v: :version,
    p: :path,
    o: :out,
    i: :in,
    t: :translator,
    s: :set_api_key,
  ]

  def options, do: @options

  def aliases, do: @aliases

  def explanations, do: @explanations

  def explanation(opt_atom) when is_atom(opt_atom), do: @explanations[opt_atom]

  def to_atom(option) when is_binary(option) do
    option
    |> String.trim_leading("-")
    |> String.replace("-", "_")
    |> String.to_atom()
  end
end
