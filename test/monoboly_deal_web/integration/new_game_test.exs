defmodule MonobolyDealWeb.NewGameIntegrationTest do
  use MonobolyDealWeb.IntegrationCase, async: true

  test "logged in player can start a new game", %{conn: conn} do
    put_player_in_session(conn, "player1")
    |> get(Routes.game_path(conn, :new))
    |> follow_button("Start")
    |> assert_response(status: 200)
  end

  test "player cannot start a new game unless logged in", %{conn: conn} do
    get(conn, Routes.game_path(conn, :new))
    |> assert_response(status: 302, path: "/")
  end

  test "second player can join an existing game", %{conn: conn} do
    player1_conn =
      put_player_in_session(conn, "player1")
      |> get(Routes.game_path(conn, :new))
      |> follow_button("Start")

    game_name = player1_conn.assigns.game_name

    conn
    |> put_player_in_session("player2")
    |> get(Routes.game_path(conn, :show, game_name))
    |> assert_response(status: 200)
  end
end
