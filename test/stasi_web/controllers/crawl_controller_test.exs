defmodule StasiWeb.CrawlControllerTest do
  use StasiWeb.ConnCase

  alias Stasi.Crawls

  @create_attrs %{body: "some body", generating_crawl_request: "7488a646-e31f-11e4-aace-600308960662"}
  @update_attrs %{body: "some updated body", generating_crawl_request: "7488a646-e31f-11e4-aace-600308960668"}
  @invalid_attrs %{body: nil, generating_crawl_request: nil}

  def fixture(:crawl) do
    {:ok, crawl} = Crawls.create_crawl(@create_attrs)
    crawl
  end

  describe "index" do
    test "lists all crawls", %{conn: conn} do
      conn = get(conn, Routes.crawl_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Crawls"
    end
  end

  describe "new crawl" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.crawl_path(conn, :new))
      assert html_response(conn, 200) =~ "New Crawl"
    end
  end

  describe "create crawl" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.crawl_path(conn, :create), crawl: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.crawl_path(conn, :show, id)

      conn = get(conn, Routes.crawl_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Crawl"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.crawl_path(conn, :create), crawl: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Crawl"
    end
  end

  describe "edit crawl" do
    setup [:create_crawl]

    test "renders form for editing chosen crawl", %{conn: conn, crawl: crawl} do
      conn = get(conn, Routes.crawl_path(conn, :edit, crawl))
      assert html_response(conn, 200) =~ "Edit Crawl"
    end
  end

  describe "update crawl" do
    setup [:create_crawl]

    test "redirects when data is valid", %{conn: conn, crawl: crawl} do
      conn = put(conn, Routes.crawl_path(conn, :update, crawl), crawl: @update_attrs)
      assert redirected_to(conn) == Routes.crawl_path(conn, :show, crawl)

      conn = get(conn, Routes.crawl_path(conn, :show, crawl))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, crawl: crawl} do
      conn = put(conn, Routes.crawl_path(conn, :update, crawl), crawl: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Crawl"
    end
  end

  describe "delete crawl" do
    setup [:create_crawl]

    test "deletes chosen crawl", %{conn: conn, crawl: crawl} do
      conn = delete(conn, Routes.crawl_path(conn, :delete, crawl))
      assert redirected_to(conn) == Routes.crawl_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.crawl_path(conn, :show, crawl))
      end
    end
  end

  defp create_crawl(_) do
    crawl = fixture(:crawl)
    {:ok, crawl: crawl}
  end
end
