defmodule Alfred.Application do
    def start(_type, _args) do
        IO.puts "Starting Alfred..."
        children = [
            Alfred.Consumer,
            Nosedrum.Storage.ETS,
            Alfred.Services.Music.Supervisor
        ]
        options = [strategy: :one_for_one, name: Alfred.Supervisor]
        Supervisor.start_link(children, options)
    end
end
