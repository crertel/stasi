defmodule StasiWeb.PageController do
  require Logger
  use StasiWeb, :controller
  alias Stasi.Requests
  alias Stasi.Requests.AgentRequest
  alias Stasi.Requests.CrawlRequest

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

    {:ok, %AgentRequest{id: req_id, content_type: req_type}} = Requests.create_agent_request(params)
    if String.contains?(req_type, "html") do
      Logger.info "#{inspect params}"
      {:ok, %CrawlRequest{}} = Requests.create_crawl_request(%{generating_request: req_id, crawled_at: DateTime.utc_now()})
    end

    conn
    |> resp(:created, "")
  end
end
