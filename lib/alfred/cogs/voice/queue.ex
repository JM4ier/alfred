defmodule Alfred.Cogs.Voice.Queue do

    @behaviour Nosedrum.Command

    alias Nostrum.Api
    alias Nostrum.Voice

    def predicates, do: []

    def command(msg, _args) do
        Api.create_message(msg.channel_id, "Here I would show a queue if this bot had that feature.")
    end
end
