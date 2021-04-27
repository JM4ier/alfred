defmodule Alfred.Cogs.Music.Join do

    @behaviour Nosedrum.Command

    alias Nostrum.Api
    alias Nostrum.Cache.GuildCache
    alias Nostrum.Voice

    @impl true
    def usage, do: ["join"]

    @impl true
    def description, 
    do: """
        Joins the voice channel you are currently in. 
        This only works for the bot owner at the moment.
        """

    @impl true
    def predicates, do: []

    defp get_voice_channel_of_msg(msg) do
           msg.guild_id
        |> GuildCache.get!()
        |> Map.get(:voice_states)
        |> Enum.find(%{}, fn v -> v.user_id == msg.author.id end)
        |> Map.get(:channel_id)
    end

    @impl true
    def command(msg, _args) do
        if msg.author.id == 177498563637542921 do
            case get_voice_channel_of_msg(msg) do
                nil ->
                    Api.create_message(
                        msg.channel_id, 
                        content: "You must be in a voice chat.", 
                        message_reference: %{message_id: msg.id}
                    )
                vc_id ->
                    IO.puts "Joining channel #{vc_id}  in server #{msg.guild_id}."
                    Voice.join_channel(msg.guild_id, vc_id)
            end
        end
    end
end
