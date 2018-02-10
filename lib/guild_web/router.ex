defmodule GuildWeb.Router do
  use GuildWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GuildWeb do
    pipe_through :api
  end
end
