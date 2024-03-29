defmodule GuildWeb.GraphQL.Resolvers.Access do
  
  alias Guild.{Groups, Accounts, Content}


  def get_self(_parent, _args, %{context: %{user_id: user_id}}) do
    case Accounts.get_user(user_id) do
      nil ->
        {:error, "User ID: #{user_id} not found"}
      
      user ->
        {:ok, user}
    end
  end

  def find_channel(_parent, %{id: id}, _resolution) do
    case Groups.get_channel(id) do
      nil ->
        {:error, "Channel ID: #{id} not found"}

      channel ->
        {:ok, channel}
    end
  end

  @doc """
  Get all channels, if active argument is specified then only
  get the channels marked active and vica versa with public argument
  """
  def list_channels(_parent, %{active: true, public: true}, _resolution) do
    {:ok, Groups.list_public_active_channels}
  end

  def list_channels(_parent, %{public: true}, _resolution), do: {:ok, Groups.list_public_channels}

  def list_channels(_parent, %{active: true}, _resolution), do: {:ok, Groups.list_active_channels}

  def list_channels(_parent, _args, _resolution), do: {:ok, Groups.list_channels}

  def find_message(_parent, %{id: id}, _resolution) do
    with %Content.Message{} = message <- Content.get_message(id),
         %Accounts.User{} = user <- Accounts.get_user(message.from),
         %Groups.Channel{} = channel <- Groups.get_channel(message.channel_id) do
      {:ok, replace_ids_with_maps(message, channel, user)}
    else
      # Hope that the user or channel match dosn't somehow fail
      nil ->
        {:error, "Message ID: #{id} not found"}
    end
  end

  defp replace_ids_with_maps(message, channel, user) do
    # replace the channel_id and from fields with actual user/channel maps instead of just ids
    message
    |> Map.drop([:channel_id, :from])
    |> Map.merge(%{channel: channel, from: user})
  end

  def user_channels(%Accounts.User{} = user, args, _resolution) do
    channels = Accounts.get_user_channels(user.id, Map.get(args, :active), Map.get(args, :public))

    {:ok, channels}
  end

  def channel_users(%Groups.Channel{} = channel, _args, _resolution) do
    users = Groups.get_channel_users(channel.id)

    {:ok, users}
  end

end