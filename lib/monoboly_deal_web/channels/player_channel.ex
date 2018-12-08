defmodule MonobolyDealWeb.PlayerChannel do
  use MonobolyDealWeb, :channel

  alias MonobolyDeal.Game.Server

  def join("players:" <> _player_name, _params, socket) do
    {:ok, socket}
  end

  def handle_in("hand_dealt", %{"game_name" => game_name}, socket) do
    case Server.game_pid(game_name) do
      pid when is_pid(pid) ->
        players_hand = Server.get_hand(game_name, socket.assigns.current_player)

        push(socket, "player_hand", %{hand: players_hand})
        {:noreply, socket}

      nil ->
        {:reply, {:error, %{reason: "Player does not exist"}}, socket}
    end
  end
end
