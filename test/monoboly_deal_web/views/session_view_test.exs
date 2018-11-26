defmodule MonobolyDealWeb.SessionViewTest do
  use MonobolyDealWeb.ConnCase, async: true
  import Phoenix.View

  test "renders new.html", %{conn: conn} do
    content =
      render_to_string(
        MonobolyDealWeb.SessionView,
        "new.html",
        conn: conn
      )

    assert String.contains?(content, "Name")
    assert String.contains?(content, "Play!")
  end
end
