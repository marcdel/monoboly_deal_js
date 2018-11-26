defmodule MonobolyDealWeb.SessionController do
  use MonobolyDealWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"player" => %{"name" => name}}) do
    player = %MonobolyDeal.Player{name: name}

    conn
    |> put_session(:current_player, player)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_player)
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
