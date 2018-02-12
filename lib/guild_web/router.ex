defmodule GuildWeb.Router do
  use GuildWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug GuildWeb.Plugs.GraphQLAuth
  end

  scope "/auth" do
    pipe_through :api

    post "/", GuildWeb.AuthController, :authenticate
  end

  # IMPORTANT: Debugging only
  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: GuildWeb.GraphQL.Schema
  end

  scope "/api" do
    pipe_through [:api, :graphql]

    forward "/", Absinthe.Plug,
      schema: GuildWeb.GraphQL.Schema
  end
end
