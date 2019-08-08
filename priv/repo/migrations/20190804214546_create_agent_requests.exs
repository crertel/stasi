defmodule Stasi.Repo.Migrations.CreateAgentRequests do
  use Ecto.Migration

  def change do
    #execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""

    create table(:agent_requests, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :url, :string
      add :origin_url, :string
      add :status_code, :integer
      add :completed_at, :utc_datetime
      add :method, :string
      add :content_type, :string
      add :content_length, :integer

      timestamps()
    end

  end
end
