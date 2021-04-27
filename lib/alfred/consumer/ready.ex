defmodule Alfred.Consumer.Ready do

    alias Nosedrum.Storage.ETS, as: CommandStorage
    alias Alfred.Cogs
    alias Nostrum.Api

    @commands %{
        "help" => Cogs.Help,
        "crash" => Cogs.Crash,
        "ping" => Cogs.Ping,
        "join" => Cogs.Music.Join,
        "leave" => Cogs.Music.Leave,
        "play" => Cogs.Music.Play,
        "skip" => Cogs.Music.Skip,
        "queue" => Cogs.Music.Queue,
    }

    @spec handle(map()) :: :ok
    def handle(_data) do
        :ok = load_commands()
        :ok = Api.update_status(:online, "you", 3)
    end

    def load_commands do
        @commands
        |> Enum.each(
            fn {name, cog} -> 
                CommandStorage.remove_command([name])
                CommandStorage.add_command([name], cog) 
            end)
    end
end
