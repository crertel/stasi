defmodule Stasi.Requests.CrawlRequest do

  @moduledoc """
  A crawl reqeust.

  Valid sources are:

  * `ingest` -- from a user
  * `crawl` -- from a crawl

  Valid statuses are:

  * `uncrawled`
  * `crawling`
  * `crawled`
  * `failed`
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "crawl_requests" do
    field :crawled_at, :utc_datetime
    field :generating_request, Ecto.UUID
    field :status, :string
    field :source, :string, default: "uncrawled"
    field :depth, :integer
    field :target, :string

    timestamps()
  end

  @doc false
  def changeset(crawl_request, attrs) do
    crawl_request
    |> cast(attrs, [:generating_request, :crawled_at, :status, :source, :depth, :target])
    |> validate_required([:generating_request, :crawled_at])
  end
end
