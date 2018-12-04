defmodule MonobolyDeal.Deck.PropertyWildCard do
  alias MonobolyDeal.Deck.PropertyWildCard

  @derive {Jason.Encoder, only: [:name]}
  @enforce_keys [:name]
  defstruct [:name]

  def new do
    %PropertyWildCard{name: :property_wild_card}
  end
end
