defmodule KeyValueStore do
  @moduledoc false

  def start do
    ProcessServer.start_server(KeyValueStore)
  end

  def init() do
    %{}
  end

  def put(pid, key, value) do
    ProcessServer.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    ProcessServer.call(pid, {:get, key})
  end

  def handle_cast({:put, key, value}, state) do
    Map.put(state, key, value)
  end

  def handle_call({:get, key}, state) do
    {Map.get(state, key), state}
  end
end
