defmodule Alfred.Services.Music.Speaker do

    use Task

    alias Alfred.Services.Music.Queue
    alias Nostrum.Voice

    def start_link gid do
        Task.start_link(fn -> loop(gid) end)
    end

    defp volume do
        0.1
    end

    defp loop(gid) do
        if Voice.ready?(gid) and not Voice.playing?(gid) do
            song = Queue.pop(Queue)
            if song do
                Voice.play(gid, song, :ytdl, volume: volume())
            end
        end
        :timer.sleep(1000)
        loop(gid)
    end

end
