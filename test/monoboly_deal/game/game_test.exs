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

      assert game.deck -- Deck.cards() == []
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

  test "joining a game you've already joined" do
    game_name = NameGenerator.generate()
    player1 = %Player{name: "player1"}

    game =
      game_name
      |> Game.new(player1)
      |> Game.deal()

    assert Enum.count(game.players) == 1
    assert [%Player{name: "player1"}] = game.players

    game = Game.join(game, player1)

    assert Enum.count(game.players) == 1
    assert [%Player{name: "player1"}] = game.players
  end

  describe "dealing a hand" do
    test "the game is not started until a hand is dealt" do
      game =
        NameGenerator.generate()
        |> Game.new(%Player{name: "player1"})

      assert game.started == false

      game =
        game
        |> Game.join(%Player{name: "player2"})
        |> Game.deal()

      assert game.started == true
    end

    test "each player is dealt a hand of 5 cards" do
      game =
        NameGenerator.generate()
        |> Game.new(%Player{name: "player1"})
        |> Game.join(%Player{name: "player2"})
        |> Game.deal()

      Enum.each(
        game.players,
        fn player ->
          assert Enum.count(player.hand) == 5
        end
      )
    end
  end

  describe "getting the game state" do
    test "returns the game state for all players" do
      game_name = NameGenerator.generate()

      game_state =
        game_name
        |> Game.new(%Player{name: "player1"})
        |> Game.join(%Player{name: "player2"})
        |> Game.deal()
        |> Game.game_state()

      assert %{
               game_name: game_name,
               players: [%{name: "player1"}, %{name: "player2"}],
               started: true
             } = game_state
    end
  end

  describe "getting the player state" do
    test "returns the player state for the current player" do
      game_name = NameGenerator.generate()
      player1 = %Player{name: "player1"}
      player2 = %Player{name: "player2"}

      player_state =
        game_name
        |> Game.new(player1)
        |> Game.join(player2)
        |> Game.deal()
        |> Game.player_state(player2)

      assert player_state.name == "player2"
      assert Enum.count(player_state.hand) == 5
    end
  end

  describe "getting a players hand" do
    test "returns the hand of the specified player" do
      game_name = NameGenerator.generate()
      player1 = %Player{name: "player1"}

      hand =
        game_name
        |> Game.new(player1)
        |> Game.join(%Player{name: "player2"})
        |> Game.deal()
        |> Game.get_hand(player1)

      assert Enum.count(hand) == 5
    end
  end
end
