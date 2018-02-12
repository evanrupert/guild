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

    @desc "Get all channels"
    field :channels, list_of(:channel) do
      arg :active, :boolean
      resolve &Resolvers.list_channels/3
    end

    @desc "Get a specific message"
    field :message, :message do
      arg :id, non_null(:id)
      resolve &Resolvers.find_message/3
    end
  end
end