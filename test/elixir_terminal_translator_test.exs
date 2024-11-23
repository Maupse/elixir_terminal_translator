defmodule ElixirTerminalTranslatorTest do
  use ExUnit.Case
  doctest ElixirTerminalTranslator

  test "greets the world" do
    assert ElixirTerminalTranslator.hello() == :world
  end
end
