defmodule GalleryManagerWeb.PageController do
  use GalleryManagerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
