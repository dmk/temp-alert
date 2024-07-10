defmodule TempAlertWeb.PageController do
  use TempAlertWeb, :controller

  def index(conn, _params) do
    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, Path.join(:code.priv_dir(:temp_alert), "static/index.html"))
  end
end
