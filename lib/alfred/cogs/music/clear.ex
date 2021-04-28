defmodule Alfred.Cogs.Music.Clear do

    @behaviour Nosedrum.Command

    alias Nostrum.Api
    alias Alfred.Services.Music.Dj
    alias Alfred.Predicates

    @impl true
    def description,
    do: """
        Clears the queue.
        This does not skip the currently playing song.
    """

    @impl true
    def usage, do: ["clear"]

    @impl true
    def predicates, do: [&Predicates.same_vc/1, &Predicates.owner_only/1]

    @impl true
    def command(msg, _args) do
        Dj.clear(msg.guild_id)
        {:ok, _msg} = Api.create_message(msg.channel_id, "Cleared all songs.")
    end
end
