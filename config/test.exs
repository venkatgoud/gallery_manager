use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gallery_manager, GalleryManagerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :gallery_manager, GalleryManager.Repo,
  username: "postgres",
  password: "postgres",
  database: "gallery_manager_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
