defmodule Stack do
  @moduledoc false

  use GenServer

  def start() do
    children = [Stack]
    Supervisor.start_link(children, strategy: :one_for_all)
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  @impl GenServer
  def init(stack) do
    {:ok, stack}
  end

  []

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  def push(pid, value) do
    GenServer.cast(pid, {:push, value})
  end

  @impl GenServer
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl GenServer
  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end

  @impl GenServer
  def handle_cast({:push, value}, stack) do
    {:noreply, [value | stack]}
  end
end
