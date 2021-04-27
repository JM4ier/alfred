defmodule Alfred.Cogs.Music.Play do

    @behaviour Nosedrum.Command

    alias Nostrum.Api
    alias Nostrum.Voice

    @impl true
    def predicates, do: []

    @impl true
    def usage, do: ["play https://youtu.be/dQw4w9WgXcQ"]

    @impl true
    def description,
    do: """
        Adds a song to the queue.
        This command requires the bot to be in a voice channel.
    """

    @impl true
    def command(msg, args) when is_nil(args) or length(args) == 0 do
        Api.create_message(msg.channel_id, "I need an url to play music.")
    end

    def command(msg, args) do
        url = hd(args)
        if Voice.ready?(msg.guild_id) do
            Alfred.Services.Music.Dj.play(msg.guild_id, url)
        else
            Api.create_message(msg.channel_id, "I need to be in a voice channel.")
        end
    end
end
