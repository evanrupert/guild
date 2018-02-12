defmodule GuildWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types GuildWeb.GraphQL.Schema.Types

  alias GuildWeb.GraphQL.Resolvers

  query do
    
    @desc "Get a specific user by id"
    field :user, :user do
      resolve &Resolvers.Access.get_self/3
    end

    @desc "Get a specific channel by id"
    field :channel, :channel do
      arg :id, non_null(:id)
      resolve &Resolvers.Access.find_channel/3
    end

    @desc "Get all channels"
    field :channels, list_of(:channel) do
      arg :active, :boolean
      arg :public, :boolean
      resolve &Resolvers.Access.list_channels/3
    end

    @desc "Get a specific message"
    field :message, :message do
      arg :id, non_null(:id)
      resolve &Resolvers.Access.find_message/3
    end

    # Mutations

    @desc "Create a User"
    field :create_user, type: :user do
      arg :username, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      arg :image_url, :string
      resolve &Resolvers.Mutations.create_user/3
    end

  end
end