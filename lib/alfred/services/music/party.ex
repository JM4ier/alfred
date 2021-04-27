defmodule Alfred.Services.Music.Party do

    use Supervisor

    alias Alfred.Services.Music

    def start_link(gid) do
        Supervisor.start_link(__MODULE__, gid, [])
    end

    @impl true
    def init(gid) do
        children = [
            {Music.Queue, name: Music.Queue},
            {Music.Speaker, gid}
        ]
        Supervisor.init(children, strategy: :one_for_all)
    end

    def queue(sup) do
        Supervisor.which_children(sup)
        |> Enum.filter(fn child -> case child do
            {Music.Queue, _, _, _} -> true
            _ -> false
        end end)
        |> Enum.map(fn {_, pid, _, _} -> pid end)
        |> hd
    end
end
