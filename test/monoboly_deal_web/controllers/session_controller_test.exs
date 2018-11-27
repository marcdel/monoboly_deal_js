defmodule MonobolyDealWeb.SessionControllerTest do
  use MonobolyDealWeb.ConnCase, async: true

  describe "new session" do
    test "renders a form", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))
      assert html_response(conn, 200)
    end
  end

  describe "create session" do
    test "creates a session for the current player", %{conn: conn} do
      attrs = %{"name" => "player1"}
      conn = post(conn, Routes.session_path(conn, :create), player: attrs)

      assert get_session(conn, :current_player) == %MonobolyDeal.Player{name: "player1"}
      assert redirected_to(conn) == Routes.game_path(conn, :new)
    end

    test "redirects to the previous page if there is one", %{conn: conn} do
      player1_conn = put_player_in_session(conn, "player1")
      player1_conn = post(player1_conn, Routes.game_path(player1_conn, :create))
      %{id: game_name} = redirected_params(player1_conn)

      player2_conn = get(conn, Routes.game_path(conn, :show, game_name))

      attrs = %{"name" => "player2"}
      player2_conn = post(player2_conn, Routes.session_path(player2_conn, :create), player: attrs)

      assert get_session(player2_conn, :current_player) == %MonobolyDeal.Player{name: "player2"}
      assert redirected_to(player2_conn) == Routes.game_path(player2_conn, :show, game_name)
    end
  end

  describe "delete session" do
    test "deletes the current player from the session", %{conn: conn} do
      conn = put_player_in_session(conn, "player1")

      conn = delete(conn, Routes.session_path(conn, :delete))

      assert redirected_to(conn) == Routes.session_path(conn, :new)
      assert get_session(conn, :current_player) == nil
    end
  end
end
