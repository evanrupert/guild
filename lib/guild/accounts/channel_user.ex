defmodule Guild.Accounts.ChannelUser do
  use Ecto.Schema
  import Ecto.Changeset
  alias Guild.Accounts.ChannelUser


  schema "channel_users" do
    field :alias, :string
    field :channel_id, :integer
    field :role, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%ChannelUser{} = channel_user, attrs) do
    channel_user
    |> cast(attrs, [:user_id, :channel_id, :role, :alias])
    |> validate_required([:user_id, :channel_id, :role])
  end
end
