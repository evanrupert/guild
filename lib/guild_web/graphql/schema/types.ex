defmodule GuildWeb.GraphQL.Schema.Types do
  use Absinthe.Schema.Notation


  object :user do
    field :id, :id
    field :username, :string
    field :email, :string
    field :image_url, :string
    field :password_hash, :string
    field :updated_at, :datetime
    field :inserted_at, :datetime
  end


  scalar :datetime, name: "DateTime" do
    parse fn input ->
      case DateTime.from_iso8601(input.value) do
        {:ok, datetime} -> {:ok, datetime}
        _ -> :error
      end
    end

    serialize fn datetime ->
      case DateTime.from_naive(datetime, "Etc/UTC") do
        {:ok, datetime} -> DateTime.to_iso8601(datetime)
        _ -> :error
      end
    end
  end

end