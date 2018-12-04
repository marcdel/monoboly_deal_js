defmodule MonobolyDeal.Deck.MoneyCard do
  alias MonobolyDeal.Deck.MoneyCard

  @derive {Jason.Encoder, only: [:name, :value]}
  @enforce_keys [:name, :value]
  defstruct [:name, :value]

  def new(value) do
    %MoneyCard{name: :money_card, value: value}
  end
end
