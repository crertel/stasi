defmodule StasiWeb.CrawlController do
  use StasiWeb, :controller

  alias Stasi.Crawls
  alias Stasi.Crawls.Crawl

  def index(conn, _params) do
    crawls = Crawls.list_crawls()
    render(conn, "index.html", crawls: crawls)
  end

  def new(conn, _params) do
    changeset = Crawls.change_crawl(%Crawl{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"crawl" => crawl_params}) do
    case Crawls.create_crawl(crawl_params) do
      {:ok, crawl} ->
        conn
        |> put_flash(:info, "Crawl created successfully.")
        |> redirect(to: Routes.crawl_path(conn, :show, crawl))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    crawl = Crawls.get_crawl!(id)
    render(conn, "show.html", crawl: crawl)
  end

  def edit(conn, %{"id" => id}) do
    crawl = Crawls.get_crawl!(id)
    changeset = Crawls.change_crawl(crawl)
    render(conn, "edit.html", crawl: crawl, changeset: changeset)
  end

  def update(conn, %{"id" => id, "crawl" => crawl_params}) do
    crawl = Crawls.get_crawl!(id)

    case Crawls.update_crawl(crawl, crawl_params) do
      {:ok, crawl} ->
        conn
        |> put_flash(:info, "Crawl updated successfully.")
        |> redirect(to: Routes.crawl_path(conn, :show, crawl))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", crawl: crawl, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    crawl = Crawls.get_crawl!(id)
    {:ok, _crawl} = Crawls.delete_crawl(crawl)

    conn
    |> put_flash(:info, "Crawl deleted successfully.")
    |> redirect(to: Routes.crawl_path(conn, :index))
  end
end
