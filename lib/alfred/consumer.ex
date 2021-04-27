defmodule Alfred.Consumer do
    alias Alfred.Consumer.{
        Ready,
        MessageCreate,
    }

    use Nostrum.Consumer

    def start_link do
        Consumer.start_link(__MODULE__)
    end

    def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
        spawn(fn -> MessageCreate.handle(msg) end)
    end

    def handle_event({:READY, data, _ws_state}) do
        Ready.handle(data)
    end

    # unhandled events
    def handle_event(event) do
    end

end
