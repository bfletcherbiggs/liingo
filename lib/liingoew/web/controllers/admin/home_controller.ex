defmodule Liingoew.Web.Admin.HomeController do
  use Liingoew.Web, :admin_controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
