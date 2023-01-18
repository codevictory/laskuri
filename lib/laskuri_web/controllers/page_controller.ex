defmodule LaskuriWeb.PageController do
  use LaskuriWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
