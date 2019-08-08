defmodule StasiWeb.CrawlRequestControllerTest do
  use StasiWeb.ConnCase

  alias Stasi.Requests

  @create_attrs %{crawled_at: "2010-04-17T14:00:00Z", generating_request: "7488a646-e31f-11e4-aace-600308960662"}
  @update_attrs %{crawled_at: "2011-05-18T15:01:01Z", generating_request: "7488a646-e31f-11e4-aace-600308960668"}
  @invalid_attrs %{crawled_at: nil, generating_request: nil}

  def fixture(:crawl_request) do
    {:ok, crawl_request} = Requests.create_crawl_request(@create_attrs)
    crawl_request
  end

  describe "index" do
    test "lists all crawl_requests", %{conn: conn} do
      conn = get(conn, Routes.crawl_request_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Crawl requests"
    end
  end

  describe "new crawl_request" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.crawl_request_path(conn, :new))
      assert html_response(conn, 200) =~ "New Crawl request"
    end
  end

  describe "create crawl_request" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.crawl_request_path(conn, :create), crawl_request: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.crawl_request_path(conn, :show, id)

      conn = get(conn, Routes.crawl_request_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Crawl request"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.crawl_request_path(conn, :create), crawl_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Crawl request"
    end
  end

  describe "edit crawl_request" do
    setup [:create_crawl_request]

    test "renders form for editing chosen crawl_request", %{conn: conn, crawl_request: crawl_request} do
      conn = get(conn, Routes.crawl_request_path(conn, :edit, crawl_request))
      assert html_response(conn, 200) =~ "Edit Crawl request"
    end
  end

  describe "update crawl_request" do
    setup [:create_crawl_request]

    test "redirects when data is valid", %{conn: conn, crawl_request: crawl_request} do
      conn = put(conn, Routes.crawl_request_path(conn, :update, crawl_request), crawl_request: @update_attrs)
      assert redirected_to(conn) == Routes.crawl_request_path(conn, :show, crawl_request)

      conn = get(conn, Routes.crawl_request_path(conn, :show, crawl_request))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, crawl_request: crawl_request} do
      conn = put(conn, Routes.crawl_request_path(conn, :update, crawl_request), crawl_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Crawl request"
    end
  end

  describe "delete crawl_request" do
    setup [:create_crawl_request]

    test "deletes chosen crawl_request", %{conn: conn, crawl_request: crawl_request} do
      conn = delete(conn, Routes.crawl_request_path(conn, :delete, crawl_request))
      assert redirected_to(conn) == Routes.crawl_request_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.crawl_request_path(conn, :show, crawl_request))
      end
    end
  end

  defp create_crawl_request(_) do
    crawl_request = fixture(:crawl_request)
    {:ok, crawl_request: crawl_request}
  end
end
