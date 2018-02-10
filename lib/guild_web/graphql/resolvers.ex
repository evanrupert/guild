defmodule GuildWeb.GraphQL.Resolvers do
  
  def find_user(_parent, %{id: id}, _resolution) do
    case Guild.Accounts.get_user(id) do
      nil ->
        {:error, "User ID: #{id} not found"}
      
      user ->
        {:ok, user}
    end
  end

  def user_channels(%Guild.Accounts.User{} = user, _args, _resolution) do
    channels = Guild.Accounts.get_user_channels(user.id)

    {:ok, channels}
  end

end