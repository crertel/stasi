defmodule Stasi.Repo.Migrations.CreateCrawls do
  use Ecto.Migration

  def change do
    create table(:crawls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :generating_crawl_request, :uuid
      add :body, :string
      add :target, :string

      timestamps()
    end

  end
end
