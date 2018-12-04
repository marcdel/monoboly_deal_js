defmodule MonobolyDealWeb.GameChannel do
  use MonobolyDealWeb, :channel

  alias MonobolyDeal.Game.Server

  def join("games:" <> game_name, _params, socket) do
    case Server.game_pid(game_name) do
      pid when is_pid(pid) ->
        send(self(), {:after_join, game_name})
        {:ok, assign(socket, :game_name, game_name)}

      nil ->
        {:error, %{reason: "Game does not exist"}}
    end
  end

  def handle_info({:after_join, game_name}, socket) do
    current_player = socket.assigns.current_player
    players_hand = Server.get_hand(game_name, current_player)
    push(socket, "player_hand", %{hand: players_hand})
    {:noreply, socket}
  end

  def handle_in("deal_hand", _params, socket) do
    "games:" <> game_name = socket.topic
    Server.game_pid(game_name)

    case Server.game_pid(game_name) do
      pid when is_pid(pid) ->
        current_player = socket.assigns.current_player
        Server.deal_hand(game_name)
        players_hand = Server.get_hand(game_name, current_player)
        push(socket, "player_hand", %{hand: players_hand})
        {:noreply, socket}

      nil ->
        {:reply, {:error, %{reason: "Game does not exist"}}, socket}
    end
  end
end
