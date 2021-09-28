defmodule Cache do
  @moduledoc false
  use GenServer

  def start() do
    {_, pid} = GenServer.start(Cache, nil)
    pid
  end

  @impl GenServer
  def init(_) do
    {:ok, %{}}
  end

  def get_pid_by_name(cache, name) do
    GenServer.call(cache, name)
  end

  @impl GenServer
  def handle_call({:server_process, name}, _from, servers) do
    case Map.fetch(servers, name) do
      {:ok, value} ->
        {:reply, value, servers}

      :error ->
        pid =
          spawn(fn ->
            receive do
              _ -> IO.puts(name)
            end
          end)

        {:reply, pid, Map.put(servers, name, pid)}
    end
  end
end
