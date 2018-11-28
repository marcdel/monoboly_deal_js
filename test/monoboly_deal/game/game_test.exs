defmodule MonobolyDeal.GameTest do
  use ExUnit.Case, async: true

  alias MonobolyDeal.Player
  alias MonobolyDeal.Deck
  alias MonobolyDeal.Game
  alias MonobolyDeal.Game.NameGenerator

  describe "creating a game" do
    test "sets the game name and adds the creator to the list of players" do
      game_name = NameGenerator.generate()
      player = %Player{name: "player1"}

      game = Game.new(game_name, player)

      assert game.name == game_name
      assert game.players == [player]
    end

    test "starts with an empty discard pile and a shuffled deck" do
      game_name = NameGenerator.generate()
      player = %Player{name: "player1"}

      game = Game.new(game_name, player)

      assert game.discard_pile == []

      assert Deck.cards() -- Deck.shuffle() == []
      refute game.deck == Deck.cards()
    end
  end

  test "joining a game" do
    game_name = NameGenerator.generate()
    player1 = %Player{name: "player1"}
    game = Game.new(game_name, player1)

    player2 = %Player{name: "player2"}
    game = Game.join(game, player2)

    assert game.players == [player1, player2]
  end

  describe "dealing a hand" do
    test "each player is dealt a hand of 5 cards" do
      game =
        NameGenerator.generate()
        |> Game.new(%Player{name: "player1"})
        |> Game.join(%Player{name: "player2"})
        |> Game.deal()

      Enum.each(game.players, fn player ->
        assert Enum.count(player.hand) == 5
      end)
    end
  end
end
