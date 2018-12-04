defmodule MonobolyDeal.Game.ServerTest do
  use ExUnit.Case, async: true

  alias MonobolyDeal.Player
  alias MonobolyDeal.Game.{NameGenerator, Server}

  test "spawning a game server process" do
    game_name = NameGenerator.generate()
    player = %Player{name: "player1"}

    assert {:ok, pid} = Server.start_link(game_name, player)

    game = :sys.get_state(pid)
    assert game.name == game_name
    assert game.players == [player]
    assert game.discard_pile == []
    assert Enum.count(game.deck) == 106
  end

  test "a game process is registered under a unique name" do
    game_name = NameGenerator.generate()
    player = %Player{name: "player1"}

    assert {:ok, _pid} = Server.start_link(game_name, player)
    assert {:error, _reason} = Server.start_link(game_name, player)
  end

  describe "game_pid" do
    test "returns a PID if it has been registered" do
      game_name = NameGenerator.generate()
      player = %Player{name: "player1"}

      {:ok, pid} = Server.start_link(game_name, player)

      assert ^pid = Server.game_pid(game_name)
    end

    test "returns nil if the game does not exist" do
      refute Server.game_pid("nonexistent-game")
    end
  end

  describe "join" do
    test "adds the player to the specified game" do
      game_name = NameGenerator.generate()
      player1 = %Player{name: "player1"}
      player2 = %Player{name: "player2"}
      {:ok, _pid} = Server.start_link(game_name, player1)

      Server.join(game_name, player2)

      game_status = Server.game_status(game_name)
      assert game_status.players == [%{name: "player1"}, %{name: "player2"}]
    end
  end

  describe "deal_hand" do
    test "deals a hand to each player and returns the updated game" do
      game_name = NameGenerator.generate()
      player = %Player{name: "player1"}
      {:ok, _pid} = Server.start_link(game_name, player)

      Server.deal_hand(game_name)

      game_status = Server.game_status(game_name)

      Enum.each(game_status.players, fn player ->
        hand = Server.get_hand(game_name, player)
        assert Enum.count(hand) == 5
      end)
    end
  end

  describe "game_status" do
    test "returns the game status for all players" do
      game_name = NameGenerator.generate()
      player = %Player{name: "player1"}
      {:ok, _pid} = Server.start_link(game_name, player)
      Server.deal_hand(game_name)

      game_status = Server.game_status(game_name)

      assert %{
               game_name: game_name,
               players: [%{name: "player1"}]
             } = game_status
    end
  end

  describe "get_hand" do
    test "returns the hand of the specified player" do
      game_name = NameGenerator.generate()
      player = %Player{name: "player1"}
      {:ok, _pid} = Server.start_link(game_name, player)
      Server.deal_hand(game_name)

      hand = Server.get_hand(game_name, player)

      assert Enum.count(hand) == 5
    end
  end
end
