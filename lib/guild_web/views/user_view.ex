defmodule GuildWeb.UserView do
  use GuildWeb, :view

  def render("show.json", %{user: user}) do
    %{
      data: render_one(user, GuildWeb.UserView, "user.json")
    }
  end

  def render("error.json", %{changeset: changeset}) do
    %{
      errors: translate_errors(changeset)
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      imageUrl: user.image_url,
      passwordHash: user.password_hash,
      insertedAt: user.inserted_at,
      updatedAt: user.updated_at
    }
  end

  defp translate_errors(changeset) do
    for {key, {reason, _}} <- changeset.errors do
      Atom.to_string(key) <> ": " <> reason
    end  
  end

end