defmodule Guild.Content.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Guild.Content.Message


  schema "messages" do
    field :body, :string
    field :channel_id, :integer
    field :from, :integer

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:body, :from, :channel_id])
    |> validate_required([:body, :from, :channel_id])
  end
end
