defmodule Mch2022Web.PageController do
  use Mch2022Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
