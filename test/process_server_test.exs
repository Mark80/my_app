defmodule ProcessServerTest do
  use ExUnit.Case
  doctest ProcessServer

  test "process server" do
    pid_server = ProcessServer.start_server(KeyValueStore)
    add_message = {:put, :key, "value"}

    state = ProcessServer.call(pid_server, add_message)

    assert state == :ok

    get_message = {:get, :key}

    value = ProcessServer.call(pid_server, get_message)

    assert value == "value"
  end
end
