defmodule GuildWeb.GraphQL.Resolvers do
  
  def find_user(_parent, %{id: id}, _resolution) do
    case Guild.Accounts.get_user(id) do
      nil ->
        {:error, "User ID: #{id} not found"}
      
      user ->
        {:ok, user}
    end
  end

  def find_channel(_parent, %{id: id}, _resolution) do
    case Guild.Groups.get_channel(id) do
      nil ->
        {:error, "Channel ID: #{id} not found"}

      channel ->
        {:ok, channel}
    end
  end

  def user_channels(%Guild.Accounts.User{} = user, _args, _resolution) do
    channels = Guild.Accounts.get_user_channels(user.id)

    {:ok, channels}
  end

  def channel_users(%Guild.Groups.Channel{} = channel, _args, _resolution) do
    users = Guild.Groups.get_channel_users(channel.id)

    {:ok, users}
  end

end