defmodule MonobolyDealWeb.GameController do
  use MonobolyDealWeb, :controller
  alias MonobolyDeal.Game.NameGenerator

  plug :require_player

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, _opts) do
    game_name = NameGenerator.generate()
    redirect(conn, to: Routes.game_path(conn, :show, game_name))
  end

  def show(conn, %{"id" => game_name}) do
    conn
    |> assign(:game_name, game_name)
    |> render("show.html")
  end

  defp require_player(conn, _opts) do
    if get_session(conn, :current_player) do
      conn
    else
      conn
      |> put_session(:return_to, conn.request_path)
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt()
    end
  end
end
