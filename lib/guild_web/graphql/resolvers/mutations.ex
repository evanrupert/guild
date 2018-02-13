defmodule GuildWeb.GraphQL.Resolvers.Mutations do
  alias Guild.{Groups, Accounts, Content}

  def create_user(_parent, args, _resolution) do
    with {:ok, user} <- Accounts.create_user(args) do
      {:ok, user}
    else
      {:error, changeset} ->
        {:error, translate_errors(changeset)}
    end
  end

  def update_user(_parent, args, %{context: %{user_id: user_id}}) do
    with %Accounts.User{} = user <- Accounts.get_user(user_id),
         {:ok, %Accounts.User{} = updated_user} <- Accounts.update_user(user, args) do
      {:ok, updated_user}
    else
      nil ->
        {:error, "User: #{user_id} not found"}

      {:error, changeset} ->
        {:error, translate_errors(changeset)}
    end
  end

  def delete_user(_parent, _args, %{context: %{user_id: user_id}}) do
    with %Accounts.User{} = user <- Accounts.get_user(user_id),
         {:ok, deleted_user} <- Accounts.delete_user(user) do
      {:ok, deleted_user}
    else
      nil ->
        {:error, "User: #{user_id} not found"}
        
      {:error, changeset} ->
        {:error, translate_errors(changeset)}
    end
  end

  @doc """
  Translate the ecto changeset errors into a binary list of errors
  """
  defp translate_errors(changeset) do
    for {key, {reason, _}} <- changeset.errors do
      Atom.to_string(key) <> ": " <> reason
    end
  end

end