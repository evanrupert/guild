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

    # User specific fields
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
  end

  # scalar :datetime, name: "DateTime" do
  #   parse fn input ->
  #     case DateTime.from_iso8601(input.value) do
  #       {:ok, datetime} -> {:ok, datetime}
  #       _ -> :error
  #     end
  #   end

  #   serialize fn datetime ->
  #     case DateTime.from_naive(datetime, "Etc/UTC") do
  #       {:ok, datetime} -> DateTime.to_iso8601(datetime)
  #       _ -> :error
  #     end
  #   end
  # end

end