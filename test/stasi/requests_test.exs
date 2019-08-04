defmodule Stasi.RequestsTest do
  use Stasi.DataCase

  alias Stasi.Requests

  describe "agent_requests" do
    alias Stasi.Requests.AgentRequest

    @valid_attrs %{completed_at: ~N[2010-04-17 14:00:00], content_length: 42, content_type: "some content_type", method: "some method", origin_url: "some origin_url", status_code: 42, url: "some url"}
    @update_attrs %{completed_at: ~N[2011-05-18 15:01:01], content_length: 43, content_type: "some updated content_type", method: "some updated method", origin_url: "some updated origin_url", status_code: 43, url: "some updated url"}
    @invalid_attrs %{completed_at: nil, content_length: nil, content_type: nil, method: nil, origin_url: nil, status_code: nil, url: nil}

    def agent_request_fixture(attrs \\ %{}) do
      {:ok, agent_request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Requests.create_agent_request()

      agent_request
    end

    test "list_agent_requests/0 returns all agent_requests" do
      agent_request = agent_request_fixture()
      assert Requests.list_agent_requests() == [agent_request]
    end

    test "get_agent_request!/1 returns the agent_request with given id" do
      agent_request = agent_request_fixture()
      assert Requests.get_agent_request!(agent_request.id) == agent_request
    end

    test "create_agent_request/1 with valid data creates a agent_request" do
      assert {:ok, %AgentRequest{} = agent_request} = Requests.create_agent_request(@valid_attrs)
      assert agent_request.completed_at == ~N[2010-04-17 14:00:00]
      assert agent_request.content_length == 42
      assert agent_request.content_type == "some content_type"
      assert agent_request.method == "some method"
      assert agent_request.origin_url == "some origin_url"
      assert agent_request.status_code == 42
      assert agent_request.url == "some url"
    end

    test "create_agent_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Requests.create_agent_request(@invalid_attrs)
    end

    test "update_agent_request/2 with valid data updates the agent_request" do
      agent_request = agent_request_fixture()
      assert {:ok, %AgentRequest{} = agent_request} = Requests.update_agent_request(agent_request, @update_attrs)
      assert agent_request.completed_at == ~N[2011-05-18 15:01:01]
      assert agent_request.content_length == 43
      assert agent_request.content_type == "some updated content_type"
      assert agent_request.method == "some updated method"
      assert agent_request.origin_url == "some updated origin_url"
      assert agent_request.status_code == 43
      assert agent_request.url == "some updated url"
    end

    test "update_agent_request/2 with invalid data returns error changeset" do
      agent_request = agent_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Requests.update_agent_request(agent_request, @invalid_attrs)
      assert agent_request == Requests.get_agent_request!(agent_request.id)
    end

    test "delete_agent_request/1 deletes the agent_request" do
      agent_request = agent_request_fixture()
      assert {:ok, %AgentRequest{}} = Requests.delete_agent_request(agent_request)
      assert_raise Ecto.NoResultsError, fn -> Requests.get_agent_request!(agent_request.id) end
    end

    test "change_agent_request/1 returns a agent_request changeset" do
      agent_request = agent_request_fixture()
      assert %Ecto.Changeset{} = Requests.change_agent_request(agent_request)
    end
  end
end
