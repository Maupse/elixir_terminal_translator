# ElixirTerminalTranslator

A Translator that uses google API to translate inside the terminal.

## Installation

Using scoop you can add the Bucket https://github.com/Maupse/MaupScoopBucket
```pwsh
> scoop bucket add MaupScoopBucket "https://github.com/maupse/MaupScoopBucket"
```

Then just run
```pwsh
> scoop install elixir-terminal-translator
```

## Basic Usage

```pwsh
> tl --help

--in, -i <ISO-639-two-letter-language-code> sets the input language for the translator 
 Example: -i en for english
--out, -o <ISO-639-two-letter-language-code> sets the output language for the translator 
 Example: -o de for german
--version, -v Boolean flag, prints out the version of the program
--path, -p <path/to/out_dir> The directory where the translated file goes, will be named <file_name>_<Iso-639-letters>
--help, -h Boolean flag, explains every option and argument given, if there are no arguments explains everything
--translator, -t google | deepl sets the translator you want to translate with
--set-api-key google:<your-google-key>&deepl:<your-deepl-key> sets API key (You need to activate it for Translation)
--set-api-key google:AIzaSyA8FJ3V0VzG-2pPQ6do3vH7V8W8h0h6HLoA

Fast syntax is: tl :<out-code> :<in-code> flags text (if there is one it will be counted as out)
You can set flags with --this-is-a-flag <argument> (no arguments for boolean flags)
Flags have to come before the text, only the head gets parsed
```