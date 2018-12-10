defmodule MonobolyDealWeb.GameChannel do
  use MonobolyDealWeb, :channel

  alias MonobolyDeal.Game.Server
  alias MonobolyDealWeb.Presence

  def join("games:" <> game_name, _params, socket) do
    case Server.game_pid(game_name) do
      pid when is_pid(pid) ->
        Server.join(game_name, current_player(socket))

        send(self(), {:after_join, game_name})
        {:ok, assign(socket, :game_name, game_name)}

      nil ->
        {:error, %{reason: "Game does not exist"}}
    end
  end

  def handle_info({:after_join, game_name}, socket) do
    players_hand = Server.get_hand(game_name, current_player(socket))
    push(socket, "player_hand", %{hand: players_hand})

    push(socket, "presence_state", Presence.list(socket))

    {:ok, _} =
      Presence.track(
        socket,
        current_player(socket).name,
        %{
          online_at: inspect(System.system_time(:seconds))
        }
      )

    {:noreply, socket}
  end

  def handle_in("deal_hand", _params, socket) do
    "games:" <> game_name = socket.topic

    case Server.game_pid(game_name) do
      pid when is_pid(pid) ->
        Server.deal_hand(game_name)
        {:noreply, socket}

      nil ->
        {:reply, {:error, %{reason: "Game does not exist"}}, socket}
    end
  end

  defp current_player(socket) do
    socket.assigns.current_player
  end
end
