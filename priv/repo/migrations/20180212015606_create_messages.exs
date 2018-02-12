defmodule Guild.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :string, size: 2000
      add :from, :integer
      add :channel_id, :integer

      timestamps()
    end

    create index(:messages, [:channel_id])
  end
end
