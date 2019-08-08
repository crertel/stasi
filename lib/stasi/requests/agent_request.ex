defmodule Stasi.Requests.AgentRequest do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "agent_requests" do
    field :completed_at, :utc_datetime
    field :content_length, :integer, default: nil
    field :content_type, :string
    field :method, :string
    field :origin_url, :string
    field :status_code, :integer
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(agent_request, attrs) do
    agent_request
    |> cast(attrs, [:url, :origin_url, :status_code, :completed_at, :method, :content_type, :content_length])
    |> validate_required([:url, :origin_url, :status_code, :completed_at, :method, :content_type, :content_length])
  end
end
