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

  @max_url_length 250

  def receive_update(conn, %{
    "completed_at" => _completed_at,
    "method" => _method,
    "origin_url" => _origin_url,
    "status_code" => _status_code,
    "url" => url,
    "content_type" => _content_type,
    "content_length" => _content_length
  } = params) do
    StasiWeb.Endpoint.broadcast("traffic:dashboard", "new_request", %{body: params})

    Logger.debug "Ingesting #{inspect params}"

    if String.length(url) < @max_url_length do
      {:ok, %AgentRequest{id: req_id, content_type: req_type}} = Requests.create_agent_request(params)
      if String.contains?(req_type, "html") do
        {:ok, %CrawlRequest{}} = Requests.create_crawl_request(%{generating_request: req_id, crawled_at: DateTime.utc_now(), target: url, depth: 0, source: "ingest"})
      end
    end

    conn
    |> resp(:created, "")
  end
end
