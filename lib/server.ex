defmodule ProcessServer do
  def start_server(module) do
    spawn(fn ->
      initial_state = module.init()
      loop(module, initial_state)
    end)
  end

  defp loop(module, current_state) do
    receive do
      {:call, request, caller} ->
        {response, new_state} = module.handle_call(request, current_state)
        send(caller, {:response, response})
        loop(module, new_state)

      {:cast, request} ->
        new_state = module.handle_cast(request, current_state)
        loop(module, new_state)
    end
  end

  def cast(server_pid, message) do
    send(server_pid, {:cast, message})
  end

  def call(server_pid, message) do
    send(server_pid, {:call, message, self()})

    receive do
      {:response, result} ->
        result
    end
  end
end
