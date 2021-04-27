defmodule Alfred.Cogs.Music.Queue do

    @behaviour Nosedrum.Command

    alias Nostrum.Api

    @impl true
    def description, do: "Displays the current music queue."

    @impl true
    def usage, do: ["queue"]

    @impl true
    def predicates, do: []

    @impl true
    def command(msg, _args) do
        Api.create_message(msg.channel_id, "Here I would show a queue if this bot had that feature.")
    end
end
