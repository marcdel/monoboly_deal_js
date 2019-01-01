defmodule MonobolyDealWeb.PlayerChannelTest do
  use MonobolyDealWeb.ChannelCase

  alias MonobolyDealWeb.PlayerChannel
  alias MonobolyDeal.Game.{NameGenerator, Server, Supervisor}
  alias MonobolyDeal.Player

  setup do
    player1 = %Player{name: "player1"}
    topic = "players:#{player1.name}"

    game_name = NameGenerator.generate()
    {:ok, _pid} = Supervisor.start_game(game_name, player1)

    token = Phoenix.Token.sign(@endpoint, "user socket", player1)

    {:ok, socket} = connect(MonobolyDealWeb.UserSocket, %{"token" => token})

    [
      game_name: game_name,
      topic: topic,
      socket: socket,
      player: player1
    ]
  end

  describe "join" do
    test "assigns the current player to the socket", context do
      {:ok, _reply, _socket} =
        subscribe_and_join(context.socket, PlayerChannel, context.topic, %{})

      assert context.socket.assigns.current_player == context.player
    end
  end

  describe "hand_dealt" do
    test "pushes the dealt hand to the current player", context do
      {:ok, _reply, socket} =
        subscribe_and_join(context.socket, PlayerChannel, context.topic, %{})

      push(socket, "hand_dealt", %{game_name: context.game_name})

      assert_push("player_hand", %{hand: hand})
      assert hand == Server.get_hand(context.game_name, context.player)
    end
  end
end
