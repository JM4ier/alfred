defmodule Alfred.Consumer.MessageCreate do

    alias Nosedrum.Invoker.Split, as: CommandInvoker
    alias Nostrum.Api
    alias Nostrum.Struct.Message

    @spec handle(Message.t()) :: :ok
    def handle(msg) do
        unless msg.author.bot do
            case CommandInvoker.handle_message(msg, Nosedrum.Storage.ETS) do
                {:error, error} ->
                    IO.puts "An error has occured: #{error}"
                _ ->
                    :ok
            end
        end
        :ok
    end
end
