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
end
