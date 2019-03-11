defmodule GalleryManager.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :caption, :string
      add :path, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:photos, [:user_id])
  end
end
