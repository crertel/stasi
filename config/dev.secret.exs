use Mix.Config

config :stasi, Stasi.Repo,
  username: "stasi",
  password: "stasistasistasi",
  database: "stasi_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
