defmodule KeyValueStore2 do
  def init(_) do
    :timer.send_interval(5000, :print_state)
    {:ok, %{}}
  end

  def start do
    GenServer.start(KeyValueStore2, nil)
  end

  def put(pid, key, value) do
    GenServer.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key), state}
  end

  def handle_info(:print_state, state) do
    IO.puts("....")
    {:noreply, state}
  end
end

# {:ok, pid} = KeyValueStore2.start
# KeyValueStore2.put(pid, :key, :ciccio)
