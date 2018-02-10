defmodule Guild.Repo.Migrations.CreateChannelUsers do
  use Ecto.Migration

  def change do
    create table(:channel_users) do
      add :user_id, :integer
      add :channel_id, :integer
      add :role, :integer
      add :alias, :string

      timestamps()
    end

  end
end
