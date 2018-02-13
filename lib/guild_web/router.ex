defmodule GuildWeb.Router do
  use GuildWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug GuildWeb.Plugs.GraphQLAuth
  end


  # IMPORTANT: Remove "/graphiql" before prod
  scope "/api" do
    pipe_through :api

    post "/user", GuildWeb.UserController, :create
    post "/auth", GuildWeb.AuthController, :authenticate

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: GuildWeb.GraphQL.Schema
  end

  scope "/api" do
    pipe_through [:api, :graphql]

    forward "/", Absinthe.Plug,
      schema: GuildWeb.GraphQL.Schema
  end
end
