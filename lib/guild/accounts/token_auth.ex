defmodule Guild.Accounts.TokenAuth do
  @secret Application.get_env(:guild, :secret_key)

  def validate_token(token) do
    case token do
      nil -> {:error, :missing_token}
      _ -> authenticate_token(token)
    end
  end

  defp authenticate_token(token) do
    case Phoenix.Token.verify(GuildWeb.Endpoint, @secret, token, max_age: 86400) do
      {:error, _} ->
        {:error, :invalid_token}

      x ->
        x
    end
  end
end