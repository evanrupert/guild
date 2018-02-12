defmodule GuildWeb.GraphQL.Resolvers do
  
  alias Guild.{Groups, Accounts, Content}

  def find_user(_parent, %{id: id}, _resolution) do
    case Accounts.get_user(id) do
      nil ->
        {:error, "User ID: #{id} not found"}
      
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
  get the channels marked active
  """
  def list_channels(_parent, %{active: true}, _resolution) do
    {:ok, Groups.list_active_channels}
  end

  def list_channels(_parent, _args, _resolution) do
    {:ok, Groups.list_channels}
  end

  def find_message(_parent, %{id: id}, _resolution) do
    with %Content.Message{} = message <- Content.get_message(id),
         %Accounts.User{} = user <- Accounts.get_user(message.from),
         %Groups.Channel{} = channel <- Groups.get_channel(message.channel_id) do
      msg = message
            |> Map.drop([:channel_id, :from])
            |> Map.merge(%{channel: channel, from: user})
      {:ok, msg}
    else
      # Hope that the user or channel match dosn't somehow fail
      nil ->
        {:error, "Message ID: #{id} not found"}
    end
  end

  def user_channels(%Accounts.User{} = user, _args, _resolution) do
    channels = Accounts.get_user_channels(user.id)

    {:ok, channels}
  end

  def channel_users(%Groups.Channel{} = channel, _args, _resolution) do
    users = Groups.get_channel_users(channel.id)

    {:ok, users}
  end

  def create_user(_parent, args, _resolution) do
    with {:ok, user} <- Accounts.create_user(args) do
      {:ok, user}
    else
      {:error, changeset} ->
        {:error, translate_errors(changeset)}
    end
  end

  defp translate_errors(changeset) do
    for {key, {reason, _}} <- changeset.errors do
      Atom.to_string(key) <> ": " <> reason
    end
  end

end