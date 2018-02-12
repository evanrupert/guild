defmodule GuildWeb.AuthView do
  use GuildWeb, :view

  def render("auth.json", %{token: token, user_id: user_id}) do
    %{
      ok: true,
      user_id: user_id,
      token: token
    }
  end

  def render("error.json", %{reason: reason}) do
    %{
      ok: false,
      reason: reason
    }
  end
end