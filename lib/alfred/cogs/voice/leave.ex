defmodule Alfred.Cogs.Voice.Leave do

    @behaviour Nosedrum.Command

    alias Nostrum.Api
    alias Nostrum.Voice

    @impl true
    def description,
    do: """
        Leaves the voice channel.
        This only works for the owner right now.
    """

    @impl true
    def usage, do: ["leave"]

    @impl true
    def predicates, do: []

    @impl true
    def command(msg, _args) do
        if msg.author.id == 177498563637542921 do
            if Voice.playing?(msg.guild_id) do
                Voice.stop(msg.guild_id)
            end
            Voice.leave_channel(msg.guild_id)
        end
    end
end
