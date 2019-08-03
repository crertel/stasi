defmodule Stasi.Repo do
  use Ecto.Repo,
    otp_app: :stasi,
    adapter: Ecto.Adapters.Postgres
end
