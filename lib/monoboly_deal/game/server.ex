defmodule MonobolyDeal.Game.Server do
  use GenServer

  alias MonobolyDeal.Game

  @timeout :timer.hours(2)

  def start_link(game_name, player) do
    GenServer.start_link(__MODULE__, {game_name, player}, name: via_tuple(game_name))
  end

  def join(game_name, player) do
    GenServer.cast(via_tuple(game_name), {:join, player})
  end

  def deal_hand(game_name) do
    GenServer.cast(via_tuple(game_name), :deal_hand)
  end

  def game_status(game_name) do
    GenServer.call(via_tuple(game_name), :game_status)
  end

  def get_hand(game_name, player) do
    GenServer.call(via_tuple(game_name), {:get_hand, player})
  end

  def game_pid(game_name) do
    game_name
    |> via_tuple()
    |> GenServer.whereis()
  end

  def via_tuple(game_name) do
    {:via, Registry, {MonobolyDeal.GameRegistry, game_name}}
  end

  def init({game_name, player}) do
    game =
      case :ets.lookup(:games_table, game_name) do
        [] ->
          game = Game.new(game_name, player)
          :ets.insert(:games_table, {game_name, game})
          game

        [{^game_name, game}] ->
          game
      end

    {:ok, game, @timeout}
  end

  def handle_cast({:join, player}, game) do
    updated_game = Game.join(game, player)
    {:noreply, updated_game, @timeout}
  end

  def handle_cast(:deal_hand, game) do
    updated_game = Game.deal(game)
    {:noreply, updated_game, @timeout}
  end

  def handle_call(:game_status, _from, game) do
    game_status = Game.game_status(game)

    {:reply, game_status, game, @timeout}
  end

  def handle_call({:get_hand, player}, _from, game) do
    player = Enum.find(game.players, fn p -> p.name == player.name end)
    {:reply, player.hand, game, @timeout}
  end
end
