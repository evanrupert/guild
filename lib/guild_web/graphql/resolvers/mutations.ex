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

  defp translate_errors(changeset) do
    for {key, {reason, _}} <- changeset.errors do
      Atom.to_string(key) <> ": " <> reason
    end
  end

end