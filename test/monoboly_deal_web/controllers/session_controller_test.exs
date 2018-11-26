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
      assert redirected_to(conn) == Routes.game_path(conn, :create)
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