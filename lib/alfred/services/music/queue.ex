defmodule Alfred.Services.Music.Queue do

    use Agent, restart: :temporary

    def start_link(_opts) do
        Agent.start_link(fn -> [] end, name: __MODULE__)
    end

    def push(queue, song) do
        Agent.update(queue, &(&1 ++ [song]))
    end

    def pop(queue) do
        Agent.get_and_update(queue, &(case &1 do
            [h | t] -> {h, t}
            [] -> {nil, []}
        end))
    end

    def shuffle(queue) do
        Agent.update(queue, &Enum.shuffle/1)
    end

    def list(queue) do
        Agent.get(queue, &(&1))
    end

    def clear(queue) do
        Agent.update(queue, fn _ -> [] end)
    end

end
