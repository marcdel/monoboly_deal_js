defmodule MonobolyDeal.Deck.PropertyCard do
  @enforce_keys [:color, :value, :rent_values]
  defstruct [:color, :value, :rent_values]
end
