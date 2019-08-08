defmodule Stasi.Crawls.Crawl do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "crawls" do
    field :target, :string
    field :body, :string
    field :generating_crawl_request, Ecto.UUID

    timestamps()
  end

  @doc false
  def changeset(crawl, attrs) do
    crawl
    |> cast(attrs, [:generating_crawl_request, :body, :target])
    |> validate_required([:generating_crawl_request, :body, :target])
  end
end
