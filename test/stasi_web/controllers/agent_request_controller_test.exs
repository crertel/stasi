defmodule StasiWeb.AgentRequestControllerTest do
  use StasiWeb.ConnCase

  alias Stasi.Requests

  @create_attrs %{completed_at: ~N[2010-04-17 14:00:00], content_length: 42, content_type: "some content_type", method: "some method", origin_url: "some origin_url", status_code: 42, url: "some url"}
  @update_attrs %{completed_at: ~N[2011-05-18 15:01:01], content_length: 43, content_type: "some updated content_type", method: "some updated method", origin_url: "some updated origin_url", status_code: 43, url: "some updated url"}
  @invalid_attrs %{completed_at: nil, content_length: nil, content_type: nil, method: nil, origin_url: nil, status_code: nil, url: nil}

  def fixture(:agent_request) do
    {:ok, agent_request} = Requests.create_agent_request(@create_attrs)
    agent_request
  end

  describe "index" do
    test "lists all agent_requests", %{conn: conn} do
      conn = get(conn, Routes.agent_request_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Agent requests"
    end
  end

  describe "new agent_request" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.agent_request_path(conn, :new))
      assert html_response(conn, 200) =~ "New Agent request"
    end
  end

  describe "create agent_request" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.agent_request_path(conn, :create), agent_request: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.agent_request_path(conn, :show, id)

      conn = get(conn, Routes.agent_request_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Agent request"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.agent_request_path(conn, :create), agent_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Agent request"
    end
  end

  describe "edit agent_request" do
    setup [:create_agent_request]

    test "renders form for editing chosen agent_request", %{conn: conn, agent_request: agent_request} do
      conn = get(conn, Routes.agent_request_path(conn, :edit, agent_request))
      assert html_response(conn, 200) =~ "Edit Agent request"
    end
  end

  describe "update agent_request" do
    setup [:create_agent_request]

    test "redirects when data is valid", %{conn: conn, agent_request: agent_request} do
      conn = put(conn, Routes.agent_request_path(conn, :update, agent_request), agent_request: @update_attrs)
      assert redirected_to(conn) == Routes.agent_request_path(conn, :show, agent_request)

      conn = get(conn, Routes.agent_request_path(conn, :show, agent_request))
      assert html_response(conn, 200) =~ "some updated content_type"
    end

    test "renders errors when data is invalid", %{conn: conn, agent_request: agent_request} do
      conn = put(conn, Routes.agent_request_path(conn, :update, agent_request), agent_request: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Agent request"
    end
  end

  describe "delete agent_request" do
    setup [:create_agent_request]

    test "deletes chosen agent_request", %{conn: conn, agent_request: agent_request} do
      conn = delete(conn, Routes.agent_request_path(conn, :delete, agent_request))
      assert redirected_to(conn) == Routes.agent_request_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.agent_request_path(conn, :show, agent_request))
      end
    end
  end

  defp create_agent_request(_) do
    agent_request = fixture(:agent_request)
    {:ok, agent_request: agent_request}
  end
end
