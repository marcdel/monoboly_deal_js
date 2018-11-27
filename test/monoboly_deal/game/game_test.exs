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
end
