defmodule GalleryManager.Media.Photo do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset


  schema "photos" do
    field :caption, :string
    field :path, GalleryManager.Path.Type
    belongs_to :user, GalleryManager.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:caption, :path])
    |> cast_attachments(attrs, [:path])
    |> validate_required([:caption, :path])
  end
end
