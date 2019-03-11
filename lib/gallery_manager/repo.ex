defmodule GalleryManager.Repo do
  use Ecto.Repo,
    otp_app: :gallery_manager,
    adapter: Ecto.Adapters.Postgres
end
