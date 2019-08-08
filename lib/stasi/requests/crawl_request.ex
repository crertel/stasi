defmodule Stasi.Requests.CrawlRequest do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "crawl_requests" do
    field :crawled_at, :utc_datetime
    field :generating_request, Ecto.UUID

    timestamps()
  end

  @doc false
  def changeset(crawl_request, attrs) do
    crawl_request
    |> cast(attrs, [:generating_request, :crawled_at])
    |> validate_required([:generating_request, :crawled_at])
  end
end
