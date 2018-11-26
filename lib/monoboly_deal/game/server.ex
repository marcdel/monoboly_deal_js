defmodule MonobolyDeal.Game.Server do
  use GenServer

  @timeout :timer.hours(2)

  def start_link(game_name, player) do
    GenServer.start_link(__MODULE__, {game_name, player}, name: via_tuple(game_name))
  end

  def via_tuple(game_name) do
    {:via, Registry, {MonobolyDeal.GameRegistry, game_name}}
  end

  def init({game_name, player}) do
    {:ok, %{}, @timeout}
  end
end
