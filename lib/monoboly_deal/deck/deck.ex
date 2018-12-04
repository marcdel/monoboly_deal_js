defmodule MonobolyDeal.Deck do
  alias MonobolyDeal.Deck.{
    MoneyCard,
    ActionCard,
    RentCard,
    PropertyCard,
    DualPropertyCard,
    PropertyWildCard
  }

  def shuffle do
    Enum.shuffle(cards())
  end

  def cards do
    []
    |> Kernel.++(for _ <- 1..6, do: MoneyCard.new(1))
    |> Kernel.++(for _ <- 1..5, do: MoneyCard.new(2))
    |> Kernel.++(for _ <- 1..3, do: MoneyCard.new(3))
    |> Kernel.++(for _ <- 1..3, do: MoneyCard.new(4))
    |> Kernel.++(for _ <- 1..2, do: MoneyCard.new(5))
    |> Kernel.++([MoneyCard.new(10)])
    |> Kernel.++(for _ <- 1..2, do: ActionCard.new(5, :deal_breaker))
    |> Kernel.++(for _ <- 1..3, do: ActionCard.new(4, :just_say_no))
    |> Kernel.++(for _ <- 1..10, do: ActionCard.new(1, :pass_go))
    |> Kernel.++(for _ <- 1..3, do: ActionCard.new(3, :forced_deal))
    |> Kernel.++(for _ <- 1..3, do: ActionCard.new(3, :sly_deal))
    |> Kernel.++(for _ <- 1..3, do: ActionCard.new(3, :debt_collectors))
    |> Kernel.++(for _ <- 1..3, do: ActionCard.new(2, :its_my_birthday))
    |> Kernel.++(for _ <- 1..2, do: ActionCard.new(1, :double_the_rent))
    |> Kernel.++(for _ <- 1..3, do: ActionCard.new(3, :house))
    |> Kernel.++(for _ <- 1..2, do: ActionCard.new(4, :hotel))
    |> Kernel.++(for _ <- 1..2, do: RentCard.new([:blue, :green]))
    |> Kernel.++(for _ <- 1..2, do: RentCard.new([:red, :yellow]))
    |> Kernel.++(for _ <- 1..2, do: RentCard.new([:pink, :orange]))
    |> Kernel.++(for _ <- 1..2, do: RentCard.new([:light_blue, :brown]))
    |> Kernel.++(for _ <- 1..2, do: RentCard.new([:railroad, :utility]))
    |> Kernel.++(
      for _ <- 1..3,
          do:
            RentCard.new([
              :blue,
              :green,
              :red,
              :yellow,
              :pink,
              :orange,
              :light_blue,
              :brown,
              :railroad,
              :utility
            ])
    )
    |> Kernel.++(for _ <- 1..2, do: PropertyCard.new(4, :blue, [3, 8]))
    |> Kernel.++(for _ <- 1..2, do: PropertyCard.new(1, :brown, [1, 2]))
    |> Kernel.++(for _ <- 1..2, do: PropertyCard.new(2, :utility, [1, 2]))
    |> Kernel.++(for _ <- 1..3, do: PropertyCard.new(4, :green, [2, 4, 7]))
    |> Kernel.++(for _ <- 1..3, do: PropertyCard.new(3, :yellow, [2, 4, 6]))
    |> Kernel.++(for _ <- 1..3, do: PropertyCard.new(3, :red, [2, 3, 6]))
    |> Kernel.++(for _ <- 1..3, do: PropertyCard.new(2, :orange, [1, 3, 5]))
    |> Kernel.++(for _ <- 1..3, do: PropertyCard.new(2, :pink, [1, 2, 4]))
    |> Kernel.++(for _ <- 1..3, do: PropertyCard.new(1, :light_blue, [1, 2, 3]))
    |> Kernel.++(for _ <- 1..4, do: PropertyCard.new(2, :railroad, [1, 2, 3, 4]))
    |> Kernel.++([
      DualPropertyCard.new(
        PropertyCard.new(4, :blue, [3, 8]),
        PropertyCard.new(4, :green, [2, 4, 7])
      )
    ])
    |> Kernel.++([
      DualPropertyCard.new(
        PropertyCard.new(4, :green, [2, 4, 7]),
        PropertyCard.new(2, :railroad, [1, 2, 3, 4])
      )
    ])
    |> Kernel.++([
      DualPropertyCard.new(
        PropertyCard.new(2, :utility, [1, 2]),
        PropertyCard.new(2, :railroad, [1, 2, 3, 4])
      )
    ])
    |> Kernel.++([
      DualPropertyCard.new(
        PropertyCard.new(1, :light_blue, [1, 2, 3]),
        PropertyCard.new(2, :railroad, [1, 2, 3, 4])
      )
    ])
    |> Kernel.++([
      DualPropertyCard.new(
        PropertyCard.new(1, :light_blue, [1, 2, 3]),
        PropertyCard.new(1, :brown, [1, 2])
      )
    ])
    |> Kernel.++(
      for _ <- 1..2,
          do:
            DualPropertyCard.new(
              PropertyCard.new(2, :pink, [1, 2, 4]),
              PropertyCard.new(2, :orange, [1, 3, 5])
            )
    )
    |> Kernel.++(
      for _ <- 1..2,
          do:
            DualPropertyCard.new(
              PropertyCard.new(3, :red, [2, 3, 6]),
              PropertyCard.new(3, :yellow, [2, 4, 6])
            )
    )
    |> Kernel.++(for _ <- 1..2, do: PropertyWildCard.new())
  end
end
