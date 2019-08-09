defmodule Stasi.Requests do
  @moduledoc """
  The Requests context.
  """

  import Ecto.Query, warn: false
  alias Stasi.Repo

  alias Stasi.Requests.AgentRequest
  alias Stasi.Requests.CrawlRequest

  import Ecto.Query, only: [from: 2]

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

  alias Stasi.Requests.CrawlRequest

  @doc """
  Returns the list of crawl_requests.

  ## Examples

      iex> list_crawl_requests()
      [%CrawlRequest{}, ...]

  """
  def list_crawl_requests do
    Repo.all(CrawlRequest)
  end

  @doc """
  Gets a single crawl_request.

  Raises `Ecto.NoResultsError` if the Crawl request does not exist.

  ## Examples

      iex> get_crawl_request!(123)
      %CrawlRequest{}

      iex> get_crawl_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_crawl_request!(id), do: Repo.get!(CrawlRequest, id)

  @doc """
  Creates a crawl_request.

  ## Examples

      iex> create_crawl_request(%{field: value})
      {:ok, %CrawlRequest{}}

      iex> create_crawl_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_crawl_request(attrs \\ %{}) do
    %CrawlRequest{}
    |> CrawlRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a crawl_request.

  ## Examples

      iex> update_crawl_request(crawl_request, %{field: new_value})
      {:ok, %CrawlRequest{}}

      iex> update_crawl_request(crawl_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_crawl_request(%CrawlRequest{} = crawl_request, attrs) do
    crawl_request
    |> CrawlRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a CrawlRequest.

  ## Examples

      iex> delete_crawl_request(crawl_request)
      {:ok, %CrawlRequest{}}

      iex> delete_crawl_request(crawl_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_crawl_request(%CrawlRequest{} = crawl_request) do
    Repo.delete(crawl_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking crawl_request changes.

  ## Examples

      iex> change_crawl_request(crawl_request)
      %Ecto.Changeset{source: %CrawlRequest{}}

  """
  def change_crawl_request(%CrawlRequest{} = crawl_request) do
    CrawlRequest.changeset(crawl_request, %{})
  end

  def list_completed_crawl_requests do
    q = from(c in CrawlRequest, where: c.status == "crawled")
    Repo.all(q)
  end

  def list_pending_crawl_requests do
    q = from(c in CrawlRequest, where: c.status == "uncrawled")
    Repo.all(q)
  end

  def list_progressing_crawl_requests do
    q = from(c in CrawlRequest, where: c.status == "crawling")
    Repo.all(q)
  end

  def list_failed_crawl_requests do
    q = from(c in CrawlRequest, where: c.status == "failed")
    Repo.all(q)
  end
end
