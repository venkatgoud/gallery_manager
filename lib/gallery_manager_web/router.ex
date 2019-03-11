defmodule GalleryManagerWeb.Router do
  use GalleryManagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GalleryManagerWeb do
    pipe_through :browser

    get "/", UserController, :index
    resources "/users", UserController do
      resources "/photos", PhotoController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", GalleryManagerWeb do
  #   pipe_through :api
  # end
end
