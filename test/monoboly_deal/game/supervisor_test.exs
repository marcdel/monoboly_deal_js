defmodule MonobolyDeal.Game.SupervisorTest do
  use ExUnit.Case, async: true

  alias MonobolyDeal.Game.{NameGenerator, Supervisor, Server}

  describe "start_game" do
    test "spawns a new supervised game process" do
      game_name = NameGenerator.generate()
      player = %MonobolyDeal.Player{name: "player1"}

      assert {:ok, _pid} = Supervisor.start_game(game_name, player)

      via = Server.via_tuple(game_name)
      assert GenServer.whereis(via) |> Process.alive?()
    end

    test "returns an error if game is already started" do
      game_name = NameGenerator.generate()
      player = %MonobolyDeal.Player{name: "player1"}

      assert {:ok, pid} = Supervisor.start_game(game_name, player)
      assert {:error, {:already_started, ^pid}} = Supervisor.start_game(game_name, player)
    end
  end
end
