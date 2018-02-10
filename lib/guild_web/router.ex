defmodule GuildWeb.Router do
  use GuildWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: GuildWeb.GraphQL.Schema

    forward "/", Absinthe.Plug,
      schema: GuildWeb.GraphQL.Schema
  end
end
