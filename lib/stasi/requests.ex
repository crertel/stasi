defmodule Stasi.Requests do
  @moduledoc """
  The Requests context.
  """

  import Ecto.Query, warn: false
  alias Stasi.Repo

  alias Stasi.Requests.AgentRequest

  @doc """
  Returns the list of agent_requests.

  ## Examples

      iex> list_agent_requests()
      [%AgentRequest{}, ...]

  """
  def list_agent_requests do
    Repo.all(AgentRequest)
  end

  @doc """
  Gets a single agent_request.

  Raises `Ecto.NoResultsError` if the Agent request does not exist.

  ## Examples

      iex> get_agent_request!(123)
      %AgentRequest{}

      iex> get_agent_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_agent_request!(id), do: Repo.get!(AgentRequest, id)

  @doc """
  Creates a agent_request.

  ## Examples

      iex> create_agent_request(%{field: value})
      {:ok, %AgentRequest{}}

      iex> create_agent_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_agent_request(attrs \\ %{}) do
    %AgentRequest{}
    |> AgentRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a agent_request.

  ## Examples

      iex> update_agent_request(agent_request, %{field: new_value})
      {:ok, %AgentRequest{}}

      iex> update_agent_request(agent_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_agent_request(%AgentRequest{} = agent_request, attrs) do
    agent_request
    |> AgentRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AgentRequest.

  ## Examples

      iex> delete_agent_request(agent_request)
      {:ok, %AgentRequest{}}

      iex> delete_agent_request(agent_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_agent_request(%AgentRequest{} = agent_request) do
    Repo.delete(agent_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking agent_request changes.

  ## Examples

      iex> change_agent_request(agent_request)
      %Ecto.Changeset{source: %AgentRequest{}}

  """
  def change_agent_request(%AgentRequest{} = agent_request) do
    AgentRequest.changeset(agent_request, %{})
  end
end
