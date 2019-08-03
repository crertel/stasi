defmodule StasiWeb.PageController do
  use StasiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def receive_update(conn, %{
    "completed_at" => completed_at,
    "method" => method,
    "origin_url" => origin_url,
    "status_code" => status_code,
    "url" => url
  } = params) do
    StasiWeb.Endpoint.broadcast("traffic:dashboard", "new_request", %{body: params})

    conn
    |> resp(:created, "")

  end
end
