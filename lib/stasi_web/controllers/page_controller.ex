defmodule StasiWeb.PageController do
  require Logger
  use StasiWeb, :controller
  alias Stasi.Requests

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def real_time(conn, _params) do
    render(conn, "real_time.html")
  end

  def receive_update(conn, %{
    "completed_at" => completed_at,
    "method" => method,
    "origin_url" => origin_url,
    "status_code" => status_code,
    "url" => url,
    "content_type" => content_type,
    "content_length" => content_length
  } = params) do
    StasiWeb.Endpoint.broadcast("traffic:dashboard", "new_request", %{body: params})

    case Requests.create_agent_request(params) do
      {:ok, agent_request} ->
        Logger.info "#{inspect params}"

      {:error, %Ecto.Changeset{} = changeset} ->
        Logger.error "Failed to make agent request"
    end

    conn
    |> resp(:created, "")

  end
end
