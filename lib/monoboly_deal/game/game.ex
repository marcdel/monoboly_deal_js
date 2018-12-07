defmodule MonobolyDeal.Game do
  defstruct [:name, :players, :discard_pile, :deck]

  alias MonobolyDeal.Deck
  alias MonobolyDeal.Game

  def new(name, player) do
    %Game{
      name: name,
      players: [player],
      discard_pile: [],
      deck: Deck.shuffle()
    }
  end

  def join(game, player) do
    %{game | players: game.players ++ [player]}
  end

  def deal(game) do
    {players, deck} =
      Enum.map_reduce(game.players, game.deck, fn player, deck ->
        {hand, updated_deck} = Enum.split(deck, 5)
        updated_player = %{player | hand: hand}

        {updated_player, updated_deck}
      end)

    %{game | players: players, deck: deck}
  end

  def game_status(game) do
    %{
      game_name: game.name,
      players:
        Enum.map(game.players, fn player ->
          %{name: player.name}
        end)
    }
  end
end
