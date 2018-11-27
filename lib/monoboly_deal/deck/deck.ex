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
    |> Kernel.++(for _ <- 1..6, do: %MoneyCard{value: 1})
    |> Kernel.++(for _ <- 1..5, do: %MoneyCard{value: 2})
    |> Kernel.++(for _ <- 1..3, do: %MoneyCard{value: 3})
    |> Kernel.++(for _ <- 1..3, do: %MoneyCard{value: 4})
    |> Kernel.++(for _ <- 1..2, do: %MoneyCard{value: 5})
    |> Kernel.++([%MoneyCard{value: 10}])
    |> Kernel.++(for _ <- 1..2, do: %ActionCard{value: 5, type: :deal_breaker})
    |> Kernel.++(for _ <- 1..3, do: %ActionCard{value: 4, type: :just_say_no})
    |> Kernel.++(for _ <- 1..10, do: %ActionCard{value: 1, type: :pass_go})
    |> Kernel.++(for _ <- 1..3, do: %ActionCard{value: 3, type: :forced_deal})
    |> Kernel.++(for _ <- 1..3, do: %ActionCard{value: 3, type: :sly_deal})
    |> Kernel.++(for _ <- 1..3, do: %ActionCard{value: 3, type: :debt_collectors})
    |> Kernel.++(for _ <- 1..3, do: %ActionCard{value: 2, type: :its_my_birthday})
    |> Kernel.++(for _ <- 1..2, do: %ActionCard{value: 1, type: :double_the_rent})
    |> Kernel.++(for _ <- 1..3, do: %ActionCard{value: 3, type: :house})
    |> Kernel.++(for _ <- 1..2, do: %ActionCard{value: 4, type: :hotel})
    |> Kernel.++(for _ <- 1..2, do: %RentCard{value: 1, colors: [:blue, :green]})
    |> Kernel.++(for _ <- 1..2, do: %RentCard{value: 1, colors: [:red, :yellow]})
    |> Kernel.++(for _ <- 1..2, do: %RentCard{value: 1, colors: [:pink, :orange]})
    |> Kernel.++(for _ <- 1..2, do: %RentCard{value: 1, colors: [:light_blue, :brown]})
    |> Kernel.++(for _ <- 1..2, do: %RentCard{value: 1, colors: [:railroad, :utility]})
    |> Kernel.++(
      for _ <- 1..3,
          do: %RentCard{
            value: 3,
            colors: [
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
            ]
          }
    )
    |> Kernel.++(for _ <- 1..2, do: %PropertyCard{value: 4, color: :blue, rent_values: [3, 8]})
    |> Kernel.++(for _ <- 1..2, do: %PropertyCard{value: 1, color: :brown, rent_values: [1, 2]})
    |> Kernel.++(for _ <- 1..2, do: %PropertyCard{value: 2, color: :utility, rent_values: [1, 2]})
    |> Kernel.++(
      for _ <- 1..3, do: %PropertyCard{value: 4, color: :green, rent_values: [2, 4, 7]}
    )
    |> Kernel.++(
      for _ <- 1..3, do: %PropertyCard{value: 3, color: :yellow, rent_values: [2, 4, 6]}
    )
    |> Kernel.++(for _ <- 1..3, do: %PropertyCard{value: 3, color: :red, rent_values: [2, 3, 6]})
    |> Kernel.++(
      for _ <- 1..3, do: %PropertyCard{value: 2, color: :orange, rent_values: [1, 3, 5]}
    )
    |> Kernel.++(for _ <- 1..3, do: %PropertyCard{value: 2, color: :pink, rent_values: [1, 2, 4]})
    |> Kernel.++(
      for _ <- 1..3, do: %PropertyCard{value: 1, color: :light_blue, rent_values: [1, 2, 3]}
    )
    |> Kernel.++(
      for _ <- 1..4, do: %PropertyCard{value: 2, color: :railroad, rent_values: [1, 2, 3, 4]}
    )
    |> Kernel.++([
      %DualPropertyCard{
        properties: [
          %PropertyCard{value: 4, color: :blue, rent_values: [3, 8]},
          %PropertyCard{value: 4, color: :green, rent_values: [2, 4, 7]}
        ]
      }
    ])
    |> Kernel.++([
      %DualPropertyCard{
        properties: [
          %PropertyCard{value: 4, color: :green, rent_values: [2, 4, 7]},
          %PropertyCard{value: 2, color: :railroad, rent_values: [1, 2, 3, 4]}
        ]
      }
    ])
    |> Kernel.++([
      %DualPropertyCard{
        properties: [
          %PropertyCard{value: 2, color: :utility, rent_values: [1, 2]},
          %PropertyCard{value: 2, color: :railroad, rent_values: [1, 2, 3, 4]}
        ]
      }
    ])
    |> Kernel.++([
      %DualPropertyCard{
        properties: [
          %PropertyCard{value: 1, color: :light_blue, rent_values: [1, 2, 3]},
          %PropertyCard{value: 2, color: :railroad, rent_values: [1, 2, 3, 4]}
        ]
      }
    ])
    |> Kernel.++([
      %DualPropertyCard{
        properties: [
          %PropertyCard{value: 1, color: :light_blue, rent_values: [1, 2, 3]},
          %PropertyCard{value: 1, color: :brown, rent_values: [1, 2]}
        ]
      }
    ])
    |> Kernel.++(
      for _ <- 1..2,
          do: %DualPropertyCard{
            properties: [
              %PropertyCard{value: 2, color: :pink, rent_values: [1, 2, 4]},
              %PropertyCard{value: 2, color: :orange, rent_values: [1, 3, 5]}
            ]
          }
    )
    |> Kernel.++(
      for _ <- 1..2,
          do: %DualPropertyCard{
            properties: [
              %PropertyCard{value: 3, color: :red, rent_values: [2, 3, 6]},
              %PropertyCard{value: 3, color: :yellow, rent_values: [2, 4, 6]}
            ]
          }
    )
    |> Kernel.++(for _ <- 1..2, do: %PropertyWildCard{})
  end
end
