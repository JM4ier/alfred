defmodule Alfred.Cogs.Crash do

    @behaviour Nosedrum.Command

    alias Nostrum.Api

    def description,
    do: """
        Crashes the bot.
        This is no joke.
    """

    def usage, do: ["crash"]

    def predicates, do: []

    def command(msg, _args) do
        raise "`#{msg.author.username}` wants to crash the bot."
    end
end
