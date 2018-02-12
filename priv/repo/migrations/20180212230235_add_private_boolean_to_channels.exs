defmodule Guild.Repo.Migrations.AddPrivateBooleanToChannels do
  use Ecto.Migration

  def change do
    alter table(:channels) do
      add :public, :boolean
    end
  end
end
