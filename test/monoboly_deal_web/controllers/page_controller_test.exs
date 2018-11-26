defmodule MonobolyDealWeb.PageControllerTest do
  use MonobolyDealWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Monoboly Deal!"
  end

  test "renders a switch player link", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Switch Player"
  end
end
