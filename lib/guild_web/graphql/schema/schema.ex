defmodule GuildWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types GuildWeb.GraphQL.Schema.Types

  alias GuildWeb.GraphQL.Resolvers

  query do
    
    @desc "Get a specific user by id"
    field :user, :user do
      arg :id, non_null(:id)
      resolve &Resolvers.find_user/3
    end
 
    @desc "Get a specific channel by id"
    field :channel, :channel do
      arg :id, non_null(:id)
      resolve &Resolvers.find_channel/3
    end
  end
end