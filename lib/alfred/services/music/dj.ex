defmodule Alfred.Services.Music.Dj do
    
    use GenServer

    alias Alfred.Services.Music.{Queue, Dj, Party, PartySupervisor}

    @impl true
    def init(:ok) do
        guilds = %{}
        refs = %{}
        {:ok, {guilds, refs}}
    end

    @impl true
    def handle_cast({:play, gid, song}, {guilds, refs}) do
        if Map.has_key?(guilds, gid) do
            q = Map.fetch!(guilds, gid)
            Queue.push(q, song)
            {:noreply, {guilds, refs}}
        else 
            {:ok, party} = DynamicSupervisor.start_child(PartySupervisor, {Party, gid})
            q = Party.queue(party)
            ref = Process.monitor(party)
            refs = Map.put(refs, ref, gid)
            guilds = Map.put(guilds, gid, q)
            Queue.push(q, song)
            {:noreply, {guilds, refs}}
        end
    end

    @impl true
    def handle_cast({:shuffle, gid}, gr) do
        queue_send_signal(gr, gid, &Queue.shuffle/1)
    end

    @impl true
    def handle_cast({:clear, gid}, gr) do
        queue_send_signal(gr, gid, &Queue.clear/1)
    end

    defp queue_send_signal({guilds, refs}, gid, fun) do
        case guilds do
            %{^gid => queue} -> fun.(queue)
            _ -> nil
        end
        {:noreply, {guilds, refs}}
    end

    @impl true
    def handle_info({:DOWN, ref, :process, _pid, _reason}, {guilds, refs}) do
        {gid, refs} = Map.pop(refs, ref)
        guilds = Map.delete(guilds, gid)
        {:noreply, {guilds, refs}}
    end

    @impl true
    def handle_info(_msg, state) do
        {:noreply, state}
    end

    def start_link(opts) do
        GenServer.start_link(__MODULE__, :ok, opts)
    end


    ## Client interface
    def play(gid, song), do: GenServer.cast(Dj, {:play, gid, song})
    def shuffle(gid), do: GenServer.cast(Dj, {:shuffle, gid})
    def clear(gid), do: GenServer.cast(Dj, {:clear, gid})
        

end
