defmodule Guild.GroupsTest do
  use Guild.DataCase

  alias Guild.Groups

  describe "channels" do
    alias Guild.Groups.Channel

    @valid_attrs %{creator: 42, end: ~N[2010-04-17 14:00:00.000000], image_url: "some image_url", latitude: "120.5", longitude: "120.5", name: "some name", start: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{creator: 43, end: ~N[2011-05-18 15:01:01.000000], image_url: "some updated image_url", latitude: "456.7", longitude: "456.7", name: "some updated name", start: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{creator: nil, end: nil, image_url: nil, latitude: nil, longitude: nil, name: nil, start: nil}

    def channel_fixture(attrs \\ %{}) do
      {:ok, channel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Groups.create_channel()

      channel
    end

    test "list_channels/0 returns all channels" do
      channel = channel_fixture()
      assert Groups.list_channels() == [channel]
    end

    test "get_channel!/1 returns the channel with given id" do
      channel = channel_fixture()
      assert Groups.get_channel!(channel.id) == channel
    end

    test "create_channel/1 with valid data creates a channel" do
      assert {:ok, %Channel{} = channel} = Groups.create_channel(@valid_attrs)
      assert channel.creator == 42
      assert channel.end == ~N[2010-04-17 14:00:00.000000]
      assert channel.image_url == "some image_url"
      assert channel.latitude == Decimal.new("120.5")
      assert channel.longitude == Decimal.new("120.5")
      assert channel.name == "some name"
      assert channel.start == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_channel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Groups.create_channel(@invalid_attrs)
    end

    test "update_channel/2 with valid data updates the channel" do
      channel = channel_fixture()
      assert {:ok, channel} = Groups.update_channel(channel, @update_attrs)
      assert %Channel{} = channel
      assert channel.creator == 43
      assert channel.end == ~N[2011-05-18 15:01:01.000000]
      assert channel.image_url == "some updated image_url"
      assert channel.latitude == Decimal.new("456.7")
      assert channel.longitude == Decimal.new("456.7")
      assert channel.name == "some updated name"
      assert channel.start == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_channel/2 with invalid data returns error changeset" do
      channel = channel_fixture()
      assert {:error, %Ecto.Changeset{}} = Groups.update_channel(channel, @invalid_attrs)
      assert channel == Groups.get_channel!(channel.id)
    end

    test "delete_channel/1 deletes the channel" do
      channel = channel_fixture()
      assert {:ok, %Channel{}} = Groups.delete_channel(channel)
      assert_raise Ecto.NoResultsError, fn -> Groups.get_channel!(channel.id) end
    end

    test "change_channel/1 returns a channel changeset" do
      channel = channel_fixture()
      assert %Ecto.Changeset{} = Groups.change_channel(channel)
    end
  end
end
