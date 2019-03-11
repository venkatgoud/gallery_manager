defmodule GalleryManager.Media do
  @moduledoc """
  The Media context.
  """

  import Ecto.Query, warn: false
  alias GalleryManager.Repo
  alias GalleryManager.Accounts

  alias GalleryManager.Media.Photo

  @doc """
  Returns the list of photos.

  ## Examples

      iex> list_photos()
      [%Photo{}, ...]

  """
  def list_photos do
    Repo.all(Photo)
  end

  def list_photos(user_id) do
    from(p in Photo, where: p.user_id == ^user_id)
    |> Repo.all()
  end


  @doc """
  Gets a single photo.

  Raises `Ecto.NoResultsError` if the Photo does not exist.

  ## Examples

      iex> get_photo!(123)
      %Photo{}

      iex> get_photo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_photo!(id), do: Repo.get!(Photo, id)

  @doc """
  Creates a photo.

  ## Examples

      iex> create_photo(%{field: value})
      {:ok, %Photo{}}

      iex> create_photo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_photo(%Accounts.User{} = user, attrs \\ %{}) do
    %Photo{}
    |> Photo.changeset(attrs)
    |> put_user(user)
    |> Repo.insert()
  end

  def create_photos(%Accounts.User{} = user, attrs \\ %{}) do 
    ## TODO what happens if the path attribute is not present    
    for imagePath <- attrs["path"] do       
      %Photo{}
      |> Photo.changeset(Map.put(attrs, "path",  imagePath))
      |> put_user(user)
      |> Repo.insert()
    end         
    {:ok,%Photo{}}
  end


  @doc """
  Updates a photo.

  ## Examples

      iex> update_photo(photo, %{field: new_value})
      {:ok, %Photo{}}

      iex> update_photo(photo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_photo(%Photo{} = photo, attrs) do
    photo
    |> Photo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Photo.

  ## Examples

      iex> delete_photo(photo)
      {:ok, %Photo{}}

      iex> delete_photo(photo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_photo(%Photo{} = photo) do
    Repo.delete(photo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking photo changes.

  ## Examples

      iex> change_photo(photo)
      %Ecto.Changeset{source: %Photo{}}

  """
  def change_photo(photo) do
    Photo.changeset(photo, %{})
  end

  defp put_user(changeset, user) do
    Ecto.Changeset.put_assoc(changeset, :user, user)
  end
end
