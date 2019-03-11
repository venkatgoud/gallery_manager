defmodule GalleryManagerWeb.PhotoController do
  use GalleryManagerWeb, :controller

  alias GalleryManager.Accounts
  alias GalleryManager.Media
  alias GalleryManager.Media.Photo

  def index(conn, %{"user_id" => user_id}) do     
    photos = Media.list_photos(user_id)
    user = Accounts.get_user!(user_id)
    # conn
    # |> assign(:photos, photos)
    # |> assign(:user_id, user_id)
    # |> render("index.html")
    render(conn, "index.html", photos: photos, user_id: user_id, username: user.name)
  end

  def new(conn, %{"user_id" => user_id}) do
    photo = %{ %Photo{} | user_id: user_id }  
    user = Accounts.get_user!(user_id)  
    changeset = Media.change_photo(photo)
    render(conn, "new.html", changeset: changeset, user_id: user_id, username: user.name)
  end

  def create(conn, %{"photo" => photo_params, "user_id" => user_id}) do
    user = Accounts.get_user!(user_id)
    case Media.create_photos(user, photo_params) do
      {:ok, photo} ->
        conn
        |> put_flash(:info, "Photo created successfully.")
        |> redirect(to: Routes.user_photo_path(conn, :index, user_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    photo = Media.get_photo!(id)
    render(conn, "show.html", photo: photo)
  end

  def edit(conn, %{"id" => id}) do
    photo = Media.get_photo!(id)
    changeset = Media.change_photo(photo)
    render(conn, "edit.html", photo: photo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "photo" => photo_params}) do
    photo = Media.get_photo!(id)

    case Media.update_photo(photo, photo_params) do
      {:ok, photo} ->
        conn
        |> put_flash(:info, "Photo updated successfully.")
        |> redirect(to: Routes.user_photo_path(conn, :show, photo.user_id, photo.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", photo: photo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    photo = Media.get_photo!(id)
    {:ok, _photo} = Media.delete_photo(photo)

    conn
    |> put_flash(:info, "Photo deleted successfully.")
    |> redirect(to: Routes.user_photo_path(conn, :index, photo.user_id))
  end
end
