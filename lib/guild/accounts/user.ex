defmodule Guild.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Guild.Accounts.User


  schema "users" do
    field :username, :string
    field :email, :string
    field :image_url, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password_hash, :image_url])
    |> validate_required([:username, :email])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end

  def registration_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:username, :email, :password])
    |> validate_length(:password, min: 8, max: 100)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        hash = Comeonin.Bcrypt.hashpwsalt(password)
        
        put_change(changeset, :password_hash, hash)

      _ ->
        changeset
    end
  end

end
