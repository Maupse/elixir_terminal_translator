defmodule ElixirTerminalTranslator.Translator.Config do
import ElixirTerminalTranslator.CLI, only: [info: 1]

  def config_path() do
    cond do
      System.get_env("Home") != nil -> Path.join(System.get_env("HOME"), ".config/elixir_terminal_translator")
      System.get_env("USERPROFILE") != nil -> Path.join(System.get_env("USERPROFILE"), ".config/elixir_terminal_translator")
      true -> IO.puts("It seems like your OS is not supported")
    end
  end

  def config_file_path, do: Path.join(config_path(), "config.json")
  def key_file_path, do: Path.join(config_path(), "keys.json")

  @default_config %{
    :in => "auto",
    :out => "en",
    :translator => "google",
  }

  # key_format "key_name: key\n"

  @spec load_config() :: {:ok, map()} | {:error, Jason.DecodeError.t() | File.posix() | Jason.EncodeError.t() | Exception.t()}
  def load_config() do
    # We make this check because otherwise we will get an :enoent error as elixir can't write on a non-existing path
    if not File.exists?(config_file_path()) do
      info("No config detected, creating new at #{config_file_path()}")
      with {:ok, map} <- write_config(@default_config)
      do map # Returns new map, created because the path or file did not exist yet
      else
        {:error, reason} -> {:error, reason}
      end
    else
      with {:ok, map} <- read_config(),
        true <- valid?(map)
      do {:ok, map} # Returns already existing map from the config file
      else
        {:error, reason} -> {:error, reason}
        false -> info("Map was invalid, resetting to default")
          write_config(@default_config)
      end
    end
  end

  @spec read_config() :: {:ok, map()} | {:error , File.posix() | Jason.DecodeError.t()}
  def read_config() do
    with {:ok, binary} <- File.read(config_file_path()),
         {:ok, json_map} <- Jason.decode(binary),
         map <- Enum.map(json_map, fn {k, v} -> {String.to_atom(k), v} end)
                |> Enum.into(%{})
    do {:ok, map}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  @spec write_key(String.t(), String.t()) :: :ok | {:error, String.t()}
  def write_key(translator, api_key) do
    if Map.has_key?(ElixirTerminalTranslator.Translator.translators(), translator) do
      case File.exists?(key_file_path()) do
        false ->
          {:ok, json} = Jason.encode(%{translator => api_key})
          File.write(key_file_path(), json)
          :ok
        true ->
          with {:ok, binary} <- File.read(key_file_path()),
            {:ok, map} <- Jason.decode(binary),
            map <- Map.put(map, translator, api_key),
            {:ok, binary} <- Jason.encode(map),
            :ok <- File.write(key_file_path(), binary)
          do :ok
          else
            {:error, someshit} -> {:error, "Couldn't write key because of error #{inspect(someshit)}"}
          end
      end
    end
  end

  @spec write_config(map()) :: {:ok, map()} | {:error, Jason.EncodeError.t() | File.posix() | String.t() | Exception.t()}
  def write_config(map) when is_map(map) do
    info("Writing new config to #{inspect(config_file_path())}")

    if not File.dir?(config_path()) do
      File.mkdir_p!(config_path())
    end

    with true <- valid?(map),
      {:ok, json} <- Jason.encode(map),
      :ok <- File.write(config_file_path(), json)
    do {:ok, map}
    else
      false -> {:error, "Missing keys in config #{inspect(map)}"}
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  A config is only valid if it has the three minimum required keys for a translation request
  The `@default_config` should always meet the requirements
  """
  @spec valid?(map()) :: boolean()
  def valid?(map) when is_map(map) do
    Enum.all?(@default_config, fn {k, _v} -> Map.has_key?(map, k) end)
  end

  @spec get_key(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def get_key(translator) do
    IO.puts("Getting API key for #{translator}")
    with :true <- File.dir?(config_path()) and File.exists?(key_file_path()),
      {:ok, binary} <- File.read(key_file_path()),
      {:ok, map} <- Jason.decode(binary),
      key when not is_nil(key) <- Map.get(map, translator)
    do {:ok, key}
    else
      false -> {:error, "It seems like there are no API keys entered yet, use --help --set-api-key for more information"}
      {:error, reason} -> {:error, reason}
      nil -> {:error, "Key was not found in key file for translator #{translator}"}
    end
  end
end
