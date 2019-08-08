defmodule Stasi.Repo.Migrations.CreateCrawlRequests do
  use Ecto.Migration

  def change do
    create table(:crawl_requests, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :generating_request, :uuid
      add :crawled_at, :utc_datetime

      timestamps()
    end

  end
end
