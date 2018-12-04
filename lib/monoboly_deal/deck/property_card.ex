defmodule MonobolyDeal.Deck.PropertyCard do
  alias MonobolyDeal.Deck.PropertyCard

  @derive {Jason.Encoder, only: [:name, :value, :color, :rent_values]}
  @enforce_keys [:name, :color, :value, :rent_values]
  defstruct [:name, :color, :value, :rent_values]

  def new(value, color, rent_values) do
    %PropertyCard{
      name: :property_card,
      value: value,
      color: color,
      rent_values: rent_values
    }
  end
end
