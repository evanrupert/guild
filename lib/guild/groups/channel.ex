defmodule Guild.Groups.Channel do
  use Ecto.Schema
  import Ecto.Changeset
  alias Guild.Groups.Channel


  schema "channels" do
    field :creator, :integer
    field :end, :naive_datetime
    field :image_url, :string
    field :latitude, :decimal
    field :longitude, :decimal
    field :name, :string
    field :start, :naive_datetime
    field :active, :boolean
    field :public, :boolean

    timestamps()
  end

  @doc false
  def changeset(%Channel{} = channel, attrs) do
    channel
    |> cast(attrs, [:name, :start, :end, :latitude, :longitude, :creator, :image_url, :active])
    |> validate_required([:name, :creator, :active])
  end
end
