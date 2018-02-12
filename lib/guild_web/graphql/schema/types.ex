defmodule GuildWeb.GraphQL.Schema.Types do
  use Absinthe.Schema.Notation

  alias GuildWeb.GraphQL.Resolvers

  import_types Absinthe.Type.Custom

  object :user do
    field :id, :id
    field :username, :string
    field :email, :string
    field :image_url, :string
    field :password_hash, :string
    field :updated_at, :naive_datetime
    field :inserted_at, :naive_datetime
    
    field :channels, list_of(:user_channel) do
      resolve &Resolvers.user_channels/3
    end
  end

  # Same as :user object but with the addtion channel-specific fields of
  # role and user_alias
  object :channel_user do
    field :username, :string
    field :email, :string
    field :image_url, :string
    field :password_hash, :string
    field :role, :integer
    field :user_alias, :string
  end


  object :channel do
    field :id, :id
    field :creator, :id
    field :name, :string
    field :image_url, :string
    field :start, :naive_datetime
    field :end, :naive_datetime
    field :latitude, :decimal
    field :longitude, :decimal
    field :updated_at, :naive_datetime
    field :inserted_at, :naive_datetime
    field :active, :boolean

    field :users, list_of(:channel_user) do
      resolve &Resolvers.channel_users/3
    end
  end


  # Same as :channel object but with the addtion user-specific fields of
  # role and user_alias
  object :user_channel do
    field :id, :id
    field :creator, :id
    field :name, :string
    field :image_url, :string
    field :start, :naive_datetime
    field :end, :naive_datetime
    field :latitude, :decimal
    field :longitude, :decimal
    field :updated_at, :naive_datetime
    field :inserted_at, :naive_datetime
    field :active, :boolean

    # User specific fields
    field :role, :integer
    field :user_alias, :string
  end


  object :message do
    field :body, :string
    field :from, :user
    field :channel, :channel
  end

end