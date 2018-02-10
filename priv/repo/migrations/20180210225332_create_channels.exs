defmodule Guild.Repo.Migrations.CreateChannels do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :name, :string
      add :start, :naive_datetime
      add :end, :naive_datetime
      add :latitude, :decimal
      add :longitude, :decimal
      add :creator, :integer
      add :image_url, :string
      add :active, :boolean

      timestamps()
    end

  end
end
