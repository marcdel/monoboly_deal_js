defmodule MonobolyDeal.Deck.ActionCard do
  alias MonobolyDeal.Deck.ActionCard

  @derive {Jason.Encoder, only: [:name, :type, :value]}
  @enforce_keys [:name, :type, :value]
  defstruct [:name, :type, :value]

  def new(value, type) do
    %ActionCard{name: :action_card, value: value, type: type}
  end
end
