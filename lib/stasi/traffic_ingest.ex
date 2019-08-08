defmodule Stasi.TrafficIngest do
  use GenServer
  require Logger



  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @ingest_refresh_rate 5_000

  @impl true
  def init(:ok) do
    Logger.info("Starting traffic ingest")
    _thandle = Process.send_after(self(), :check_traffic, @ingest_refresh_rate)
    {:ok, %{}}
  end

  @impl true
  def handle_info( :check_traffic, state) do
    Logger.info "Checking traffic"
    # for traffic that does matter, schedule it for crawling



    # schedule ourselves again
    _thandle = Process.send_after(self(), :check_traffic, @ingest_refresh_rate)

    {:noreply, state}
  end

end
