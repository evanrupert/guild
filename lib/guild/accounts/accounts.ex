defmodule Guild.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Guild.Repo

  alias Guild.Accounts.{User, ChannelUser}
  alias Guild.Groups.Channel
  

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Same as `get_user!/1` but will return nil instead of raise an error
  """
  def get_user(id), do: Repo.get(User, id)

  @doc """
  Get all channels associated with a user
  """
  def get_user_channels(user_id, active, public) do
    # Splice the Channel and ChannelUser tables to get both channel-only data
    # and also channel-user association data in one map
    query = 
      from c in Channel,
        join: cu in ChannelUser, where: cu.channel_id == c.id,
        where: cu.user_id == ^user_id,
        select: %{
          creator: c.creator,
          end: c.end,
          image_url: c.image_url,
          latitude: c.latitude,
          longitude: c.longitude,
          name: c.name,
          start: c.start,
          active: c.active,
          public: c.public,
          role: cu.role,
          user_alias: cu.alias,
          id: c.id,
          inserted_at: c.inserted_at,
          updated_at: c.updated_at
        }

    query
    |> filter_public(public)
    |> filter_active(active)
    |> Repo.all()
  end

  defp filter_public(query, true), do: query |> where([c], c.public == true)

  defp filter_public(query, _), do: query

  defp filter_active(query, true), do: query |> where([c], c.active == true)

  defp filter_active(query, _), do: query

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
    Get user out of database by email

    ## Examples

        iex> get_user_by_email("andrew@official.com")
        %User{}

  """
  def get_user_by_email(email) do
    User
    |> where([u], u.email == ^email)
    |> Repo.one
  end

  @doc """
    Authenticate user against database

    ## Examples

        iex> authenticate("andrew@official.com", "password")
        {:error, :unauthorized}
  
  """
  def authenticate(email, password) do
    with %User{} = user <- get_user_by_email(email),
         true <- check_password(user, password) do
      {:ok, user}
    else
      _ -> {:error, :unauthorized}
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> Comeonin.Bcrypt.dummy_checkpw()
      _ -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end

  alias Guild.Accounts.ChannelUser

  @doc """
  Returns the list of channel_users.

  ## Examples

      iex> list_channel_users()
      [%ChannelUser{}, ...]

  """
  def list_channel_users do
    Repo.all(ChannelUser)
  end

  @doc """
  Gets a single channel_user.

  Raises `Ecto.NoResultsError` if the Channel user does not exist.

  ## Examples

      iex> get_channel_user!(123)
      %ChannelUser{}

      iex> get_channel_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_channel_user!(id), do: Repo.get!(ChannelUser, id)

  @doc """
  Creates a channel_user.

  ## Examples

      iex> create_channel_user(%{field: value})
      {:ok, %ChannelUser{}}

      iex> create_channel_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_channel_user(attrs \\ %{}) do
    %ChannelUser{}
    |> ChannelUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a channel_user.

  ## Examples

      iex> update_channel_user(channel_user, %{field: new_value})
      {:ok, %ChannelUser{}}

      iex> update_channel_user(channel_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_channel_user(%ChannelUser{} = channel_user, attrs) do
    channel_user
    |> ChannelUser.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ChannelUser.

  ## Examples

      iex> delete_channel_user(channel_user)
      {:ok, %ChannelUser{}}

      iex> delete_channel_user(channel_user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_channel_user(%ChannelUser{} = channel_user) do
    Repo.delete(channel_user)
  end

  @doc """
  Deletes all channel_users with the given server id
  """
  def delete_channel_users_by_channel(channel_id) do
    ChannelUser
    |> where([cu], cu.channel_id == ^channel_id)
    |> Repo.delete_all
  end

  @doc """
  Deletes all channel_users with the given user_id
  """
  def delete_channel_users_by_user(user_id) do
    ChannelUser
    |> where([cu], cu.user_id == ^user_id)
    |> Repo.delete_all
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking channel_user changes.

  ## Examples

      iex> change_channel_user(channel_user)
      %Ecto.Changeset{source: %ChannelUser{}}

  """
  def change_channel_user(%ChannelUser{} = channel_user) do
    ChannelUser.changeset(channel_user, %{})
  end
end
