defmodule StasiWeb.AgentRequestController do
  use StasiWeb, :controller

  alias Stasi.Requests
  alias Stasi.Requests.AgentRequest

  def index(conn, _params) do
    agent_requests = Requests.list_agent_requests()
    render(conn, "index.html", agent_requests: agent_requests)
  end

  def new(conn, _params) do
    changeset = Requests.change_agent_request(%AgentRequest{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"agent_request" => agent_request_params}) do
    case Requests.create_agent_request(agent_request_params) do
      {:ok, agent_request} ->
        conn
        |> put_flash(:info, "Agent request created successfully.")
        |> redirect(to: Routes.agent_request_path(conn, :show, agent_request))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    agent_request = Requests.get_agent_request!(id)
    render(conn, "show.html", agent_request: agent_request)
  end

  def edit(conn, %{"id" => id}) do
    agent_request = Requests.get_agent_request!(id)
    changeset = Requests.change_agent_request(agent_request)
    render(conn, "edit.html", agent_request: agent_request, changeset: changeset)
  end

  def update(conn, %{"id" => id, "agent_request" => agent_request_params}) do
    agent_request = Requests.get_agent_request!(id)

    case Requests.update_agent_request(agent_request, agent_request_params) do
      {:ok, agent_request} ->
        conn
        |> put_flash(:info, "Agent request updated successfully.")
        |> redirect(to: Routes.agent_request_path(conn, :show, agent_request))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", agent_request: agent_request, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    agent_request = Requests.get_agent_request!(id)
    {:ok, _agent_request} = Requests.delete_agent_request(agent_request)

    conn
    |> put_flash(:info, "Agent request deleted successfully.")
    |> redirect(to: Routes.agent_request_path(conn, :index))
  end
end
