defmodule Alfred.Services.Music.Supervisor do

    use Supervisor

    alias Alfred.Services.Music

    def start_link(opts) do
        Supervisor.start_link(__MODULE__, :ok, opts)
    end

    @impl true
    def init(:ok) do
        children = [
            {Music.Dj, name: Music.Dj},
            {DynamicSupervisor, name: Music.PartySupervisor, strategy: :one_for_one}
        ]

        Supervisor.init(children, strategy: :one_for_all)
    end
end
