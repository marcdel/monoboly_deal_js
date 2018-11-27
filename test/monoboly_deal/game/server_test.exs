defmodule MonobolyDeal.Game.ServerTest do
  use ExUnit.Case, async: true

  alias MonobolyDeal.Game.Server
  alias MonobolyDeal.Game.NameGenerator

  test "spawning a game server process" do
    game_name = NameGenerator.generate()
    player = %MonobolyDeal.Player{name: "player1"}

    assert {:ok, _pid} = Server.start_link(game_name, player)
  end

  test "a game process is registered under a unique name" do
    game_name = NameGenerator.generate()
    player = %MonobolyDeal.Player{name: "player1"}

    assert {:ok, _pid} = Server.start_link(game_name, player)
    assert {:error, _reason} = Server.start_link(game_name, player)
  end

  describe "game_pid" do
    test "returns a PID if it has been registered" do
      game_name = NameGenerator.generate()
      player = %MonobolyDeal.Player{name: "player1"}

      {:ok, pid} = Server.start_link(game_name, player)

      assert ^pid = Server.game_pid(game_name)
    end

    test "returns nil if the game does not exist" do
      refute Server.game_pid("nonexistent-game")
    end
  end
end
