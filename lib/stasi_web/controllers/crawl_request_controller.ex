defmodule StasiWeb.CrawlRequestController do
  use StasiWeb, :controller

  alias Stasi.Requests
  alias Stasi.Requests.CrawlRequest

  def index(conn, _params) do
    render(conn, "index.html", completed_requests: Requests.list_completed_crawl_requests(),
                              pending_requests: Requests.list_pending_crawl_requests(),
                              progressing_requests: Requests.list_progressing_crawl_requests(),
                              failed_requests: Requests.list_failed_crawl_requests())
  end

  def new(conn, _params) do
    changeset = Requests.change_crawl_request(%CrawlRequest{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"crawl_request" => crawl_request_params}) do
    case Requests.create_crawl_request(crawl_request_params) do
      {:ok, crawl_request} ->
        conn
        |> put_flash(:info, "Crawl request created successfully.")
        |> redirect(to: Routes.crawl_request_path(conn, :show, crawl_request))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    crawl_request = Requests.get_crawl_request!(id)
    render(conn, "show.html", crawl_request: crawl_request)
  end

  def edit(conn, %{"id" => id}) do
    crawl_request = Requests.get_crawl_request!(id)
    changeset = Requests.change_crawl_request(crawl_request)
    render(conn, "edit.html", crawl_request: crawl_request, changeset: changeset)
  end

  def update(conn, %{"id" => id, "crawl_request" => crawl_request_params}) do
    crawl_request = Requests.get_crawl_request!(id)

    case Requests.update_crawl_request(crawl_request, crawl_request_params) do
      {:ok, crawl_request} ->
        conn
        |> put_flash(:info, "Crawl request updated successfully.")
        |> redirect(to: Routes.crawl_request_path(conn, :show, crawl_request))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", crawl_request: crawl_request, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    crawl_request = Requests.get_crawl_request!(id)
    {:ok, _crawl_request} = Requests.delete_crawl_request(crawl_request)

    conn
    |> put_flash(:info, "Crawl request deleted successfully.")
    |> redirect(to: Routes.crawl_request_path(conn, :index))
  end
end
