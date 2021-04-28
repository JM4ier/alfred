defmodule Alfred.Cogs.Music.Queue do

    @behaviour Nosedrum.Command

    alias Nostrum.Api
    alias Nostrum.Struct.Embed
    alias Alfred.Services.Music.Dj
    alias Alfred.Predicates

    @impl true
    def description, do: "Displays the current music queue."

    @impl true
    def usage, do: ["queue"]

    @impl true
    def predicates, do: [&Predicates.same_vc/1]

    @impl true
    def command(msg, _args) do
        queue = Dj.list(msg.guild_id)
        embed = %Embed{
            title: "Upcoming songs",
            description: Enum.join(queue, "\n")
        }
        {:ok, _} = Api.create_message(msg.channel_id, embed: embed)
    end
end
