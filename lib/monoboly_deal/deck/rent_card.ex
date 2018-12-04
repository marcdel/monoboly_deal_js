defmodule MonobolyDeal.Deck.RentCard do
  alias MonobolyDeal.Deck.RentCard

  @derive {Jason.Encoder, only: [:name, :value, :colors]}
  @enforce_keys [:name, :colors, :value]
  defstruct [:name, :colors, :value]

  def new(colors) do
    %RentCard{name: :rent_card, value: 1, colors: colors}
  end
end
