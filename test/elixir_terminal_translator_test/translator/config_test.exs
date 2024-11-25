defmodule ElixirTerminalTranslatorTest.TranslatorTest.ConfigTest do
  use ExUnit.Case, async: true
  doctest ElixirTerminalTranslator.Translator.Config

  @tag :unit
  test "write config fails on invalid config" do
    invalid_config = %{
      transilator: "google",
      in: "de",
      out: "en",
    }
    {result, item} = ElixirTerminalTranslator.Translator.Config.write_config(invalid_config)
    assert :error == result
    assert true == is_binary(item)
  end

  @tag :unit
  test "get google key fails on no key entered"  do
    {result, item} = ElixirTerminalTranslator.Translator.Config.get_key("google")
    assert :error == result
    assert true == is_binary(item)
  end
end
