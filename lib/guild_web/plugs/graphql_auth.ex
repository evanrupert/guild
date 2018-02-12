defmodule GuildWeb.Plugs.GraphQLAuth do
  @behaviour Plug

  import Plug.Conn

  alias Guild.Accounts.TokenAuth

  def init(opts), do: opts

  def call(conn, _) do
    with "Bearer " <> token <- List.first(get_req_header(conn, "authorization")),
         {:ok, user_id} <- TokenAuth.validate_token(token) do
      put_private(conn, :absinthe, %{context: %{user_id: user_id}})
    else
      nil ->
        conn
        |> send_error(%{error: "Missing authenticateion token"})

      {:error, :missing_token} ->
        conn
        |> send_error(%{error: "Missing authentication token"})

      {:error, :invalid_token} ->
        conn
        |> send_error(%{error: "Invalid authentication token"})
    end
  end

  defp send_error(conn, body) do
    json_body = Poison.encode!(body)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, json_body)
    |> halt
  end
end