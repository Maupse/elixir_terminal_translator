defmodule ElixirTerminalTranslator.Options do

  @options [
    help: :boolean,
    version: :boolean,
    file: :string,
    path: :string,
    in_lang: :string,
    out_lang: :string,
  ]

  @explanations %{
    help: "--help, -h: Boolean flag, explains every option and argument given, if there are no arguments explains everything",
    version: "--version, -v: Boolean flag, prints out the version of the program",
    file: "--file, -f: <path/to/file.txt> An input file to translate text from",
    path: "--path, -p: <path/to/out_dir> The directory where the translated file goes, will be named <file_name>_<Iso-639-letters>",
    in_lang: "--in-lang, -i: <ISO-639-two-letter-language-code> sets the input language for the translator \n Example: -i en for english",
    out_lang: "--out-lang, -o: <ISO-639-two-letter-language-code> sets the output language for the translator \n Example: -o de for german",
  }

  @aliases [
    h: :help,
    v: :version,
    p: :path,
    f: :file,
    o: :out_lang,
    i: :in_lang,
  ]

  def options do
    @options
  end

  def aliases do
    @aliases
  end

  def to_atom(option) when is_binary(option) do
    option
    |> String.trim_leading("-")
    |> String.replace("-", "_")
    |> String.to_atom()
  end

  def explanation(opt_atom) do
    @explanations[opt_atom]
  end
end
