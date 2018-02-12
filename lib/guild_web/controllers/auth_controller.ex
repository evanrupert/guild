defmodule GuildWeb.AuthController do
  use GuildWeb, :controller

  alias Guild.Accounts

  @secret Application.get_env(:guild, :secret_key)

  def authenticate(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate(email, password) do
      {:ok, user} ->
        token = Phoenix.Token.sign(GuildWeb.Endpoint, @secret, user.id)
        render(conn, "auth.json", %{token: token, user_id: user.id})
        
      {:error, _} ->
        render(conn, "error.json", %{reason: "Invalid credentials"})
    end
  end
end