defmodule MonobolyDealWeb.GameChannelTest do
  use MonobolyDealWeb.ChannelCase

  alias MonobolyDealWeb.GameChannel
  alias MonobolyDeal.Game.{NameGenerator, Server, Supervisor}
  alias MonobolyDeal.Player

  setup do
    game_name = NameGenerator.generate()
    topic = "games:#{game_name}"

    player1 = %Player{name: "player1"}
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
    test "assigns the current player to the socket and returns a nil hand", context do
      {:ok, _reply, _socket} = subscribe_and_join(context.socket, GameChannel, context.topic, %{})

      assert context.socket.assigns.current_player == context.player
      assert_push("player_hand", %{hand: nil})
    end

    test "pushes the players current hand if one has already been dealt", context do
      Server.deal_hand(context.game_name)
      hand = Server.get_hand(context.game_name, context.player)

      {:ok, _reply, _socket} = subscribe_and_join(context.socket, GameChannel, context.topic, %{})

      assert_push("player_hand", %{hand: ^hand})
    end

    test "returns error if game does not exist", context do
      assert {:error, %{reason: "Game does not exist"}} =
               subscribe_and_join(context.socket, GameChannel, "games:9999", %{})
    end
  end

  describe "deal_hand" do
    test "pushes the dealt hand to the current player", context do
      {:ok, _reply, socket} = subscribe_and_join(context.socket, GameChannel, context.topic, %{})

      push(socket, "deal_hand", %{})

      hand = Server.get_hand(context.game_name, context.player)
      assert_push("player_hand", %{hand: ^hand})
    end

    test "returns an error if game does not exist", context do
      {:ok, _reply, socket} = subscribe_and_join(context.socket, GameChannel, context.topic, %{})
      pid = Server.game_pid(context.game_name)
      Process.exit(pid, :kill)

      ref = push(socket, "deal_hand", %{})

      assert_reply(ref, :error, %{reason: "Game does not exist"})
    end
  end
end
