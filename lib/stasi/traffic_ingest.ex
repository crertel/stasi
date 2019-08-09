defmodule Stasi.TrafficIngest do
  use GenServer
  require Logger

  alias Stasi.Requests
  alias Stasi.Crawls

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @ingest_refresh_rate 5_000

  @impl true
  def init(:ok) do
    Logger.info("Starting traffic ingest")
    #_thandle = Process.send_after(self(), :check_traffic, @ingest_refresh_rate)
    {:ok, %{}}
  end

  @max_concurrent_crawls 3

  @impl true
  def handle_info( :check_traffic, state) do
    Logger.info "Checking traffic"
    [pending_crawls| _] =
                    Requests.list_pending_crawl_requests()
                    |> Enum.chunk_every(@max_concurrent_crawls)

    for crawl <- pending_crawls do
      {:ok, _ } = Requests.update_crawl_request(crawl, %{state: "crawling"})
    end

    _thandle = Process.send_after(self(), :check_traffic, @ingest_refresh_rate)
    {:noreply, state}
  end

end
