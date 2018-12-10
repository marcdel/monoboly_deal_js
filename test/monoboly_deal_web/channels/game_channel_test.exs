defmodule MonobolyDealWeb.GameChannelTest do
  use MonobolyDealWeb.ChannelCase, async: true

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
    test "joins the specified game", context do
      {:ok, _reply, _socket} = subscribe_and_join(context.socket, GameChannel, context.topic, %{})

      game_status = Server.game_status(context.game_name)
      assert Enum.map(game_status.players, fn player -> player.name end) == [context.player.name]
    end

    test "pushes the players current hand if one has already been dealt", context do
      Server.deal_hand(context.game_name)
      hand = Server.get_hand(context.game_name, context.player)

      {:ok, _reply, _socket} = subscribe_and_join(context.socket, GameChannel, context.topic, %{})

      assert_push("player_hand", %{hand: ^hand})
    end

    test "pushes presence state to the player", context do
      {:ok, _reply, _socket} = subscribe_and_join(context.socket, GameChannel, context.topic, %{})

      assert_push("presence_state", %{})

      player2 = %Player{name: "player2"}
      player2_token = Phoenix.Token.sign(@endpoint, "user socket", player2)
      {:ok, player2_socket} = connect(MonobolyDealWeb.UserSocket, %{"token" => player2_token})

      {:ok, _reply, player2_socket} =
        subscribe_and_join(player2_socket, GameChannel, context.topic, %{})

      assert_push("presence_state", %{})
    end

    test "a second player can join the game", context do
      player2 = %Player{name: "player2"}
      player2_token = Phoenix.Token.sign(@endpoint, "user socket", player2)
      {:ok, player2_socket} = connect(MonobolyDealWeb.UserSocket, %{"token" => player2_token})

      {:ok, _reply, player2_socket} =
        subscribe_and_join(player2_socket, GameChannel, context.topic, %{})

      push(player2_socket, "deal_hand", %{})

      assert_push("player_hand", %{hand: player2_hand})
      assert player2_hand == Server.get_hand(context.game_name, player2)
    end

    test "returns error if game does not exist", context do
      assert {:error, %{reason: "Game does not exist"}} =
               subscribe_and_join(context.socket, GameChannel, "games:9999", %{})
    end
  end

  describe "deal_hand" do
    @tag :skip
    test "broadcasts the dealt hand to the current player", context do
      {:ok, _reply, socket} = subscribe_and_join(context.socket, GameChannel, context.topic, %{})

      push(socket, "deal_hand", %{})

      assert_broadcast("player_hand", %{hand: hand})
      assert hand == Server.get_hand(context.game_name, context.player)
    end

    @tag :skip # figure out how, and at what level, to test this
    test "broadcasts a message to each player in the game with their hand", context do
      player2 = %Player{name: "player2"}
      player2_token = Phoenix.Token.sign(@endpoint, "user socket", player2)
      {:ok, player2_socket} = connect(MonobolyDealWeb.UserSocket, %{"token" => player2_token})

      {:ok, _reply, player2_socket} =
        subscribe_and_join(player2_socket, GameChannel, context.topic, %{})

      push(player2_socket, "deal_hand", %{})

      player1_topic = "players:" <> context.player.name
      hand = Server.get_hand(context.game_name, context.player)
      assert_receive(
        %Phoenix.Socket.Broadcast{
          event: "player_hand",
          topic: ^player1_topic,
          payload: %{
            hand: ^hand
          }
        },
        100
      )
      assert_broadcast("player_hand", %{hand: ^hand})

      hand2 = Server.get_hand(context.game_name, player2)
      assert_broadcast("player_hand", %{hand: ^hand2})
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
