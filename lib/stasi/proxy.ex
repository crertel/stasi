defmodule Stasi.Proxy do
  use GenServer

  require Logger

  # defstruct

  def start_link(_args) do
    Logger.info("Starting proxy")
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(s) do
    {:ok, s}
  end

  def annouce_request(request) do
    StasiWeb.Endpoint.broadcast!("traffic:dashboard", "new_request", %{body: request})
  end

end
