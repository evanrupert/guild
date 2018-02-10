defmodule GuildWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types GuildWeb.GraphQL.Schema.Types

  alias GuildWeb.GraphQL.Resolvers

  query do
    
    @desc "Get a user"
    field :user, :user do
      arg :id, non_null(:id)
      resolve &Resolvers.find_user/3
    end
  end
end