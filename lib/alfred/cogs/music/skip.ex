defmodule Alfred.Cogs.Music.Skip do

    @behaviour Nosedrum.Command

    alias Nostrum.Api
    alias Nostrum.Voice
    alias Alfred.Predicates

    @impl true
    def description,
    do: """
        Skips the currently playing song.
    """

    @impl true
    def usage, do: ["skip"]

    @impl true
    def predicates, do: [&Predicates.same_vc/1]

    @impl true
    def command(msg, _args) when msg.author.id == 155419933998579713 do
        Api.create_message(msg.channel_id, "Andri stop skipping songs ffs.")
    end

    def command(msg, _args) do
        Voice.stop(msg.guild_id)
        Api.create_message(msg.channel_id, "Skipped the current song.")
    end
end
