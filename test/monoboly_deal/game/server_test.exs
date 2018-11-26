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
end
