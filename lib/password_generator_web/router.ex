defmodule PasswordGeneratorWeb.Router do
  use PasswordGeneratorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PasswordGeneratorWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PasswordGeneratorWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/", PageController, :generate
  end

  scope "/api", PasswordGeneratorWeb.Api do
    pipe_through :api

    post "/", PageController, :api_generate
  end
end
