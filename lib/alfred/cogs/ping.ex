defmodule Alfred.Cogs.Ping do

    @behaviour Nosedrum.Command

    alias Nostrum.Api

    @impl true
    def description, do: "Responds with Pong."

    @impl true
    def usage, do: ["ping"]

    @impl true
    def predicates, do: []

    @impl true
    def command(msg, _args) do
        Api.create_message(msg.channel_id, content: "Pong!", message_reference: %{message_id: msg.id})
    end
end
