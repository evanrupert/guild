defmodule GuildWeb.UserController do
  use GuildWeb, :controller

  alias Guild.Accounts

  def create(conn, %{"user" => attrs}) do
    case Accounts.create_user(attrs) do
      {:ok, user} ->
        render(conn, "show.json", %{user: user})

      {:error, changeset} ->
        render(conn, "error.json", %{changeset: changeset})
    end
  end
  
end