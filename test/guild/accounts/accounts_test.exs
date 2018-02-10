defmodule Guild.AccountsTest do
  use Guild.DataCase

  alias Guild.Accounts

  describe "users" do
    alias Guild.Accounts.User

    @valid_attrs %{email: "some email", image_url: "some image_url", password_hash: "some password_hash", username: "some username"}
    @update_attrs %{email: "some updated email", image_url: "some updated image_url", password_hash: "some updated password_hash", username: "some updated username"}
    @invalid_attrs %{email: nil, image_url: nil, password_hash: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.image_url == "some image_url"
      assert user.password_hash == "some password_hash"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.image_url == "some updated image_url"
      assert user.password_hash == "some updated password_hash"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "channel_users" do
    alias Guild.Accounts.ChannelUser

    @valid_attrs %{alias: "some alias", channel_id: 42, role: 42, user_id: 42}
    @update_attrs %{alias: "some updated alias", channel_id: 43, role: 43, user_id: 43}
    @invalid_attrs %{alias: nil, channel_id: nil, role: nil, user_id: nil}

    def channel_user_fixture(attrs \\ %{}) do
      {:ok, channel_user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_channel_user()

      channel_user
    end

    test "list_channel_users/0 returns all channel_users" do
      channel_user = channel_user_fixture()
      assert Accounts.list_channel_users() == [channel_user]
    end

    test "get_channel_user!/1 returns the channel_user with given id" do
      channel_user = channel_user_fixture()
      assert Accounts.get_channel_user!(channel_user.id) == channel_user
    end

    test "create_channel_user/1 with valid data creates a channel_user" do
      assert {:ok, %ChannelUser{} = channel_user} = Accounts.create_channel_user(@valid_attrs)
      assert channel_user.alias == "some alias"
      assert channel_user.channel_id == 42
      assert channel_user.role == 42
      assert channel_user.user_id == 42
    end

    test "create_channel_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_channel_user(@invalid_attrs)
    end

    test "update_channel_user/2 with valid data updates the channel_user" do
      channel_user = channel_user_fixture()
      assert {:ok, channel_user} = Accounts.update_channel_user(channel_user, @update_attrs)
      assert %ChannelUser{} = channel_user
      assert channel_user.alias == "some updated alias"
      assert channel_user.channel_id == 43
      assert channel_user.role == 43
      assert channel_user.user_id == 43
    end

    test "update_channel_user/2 with invalid data returns error changeset" do
      channel_user = channel_user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_channel_user(channel_user, @invalid_attrs)
      assert channel_user == Accounts.get_channel_user!(channel_user.id)
    end

    test "delete_channel_user/1 deletes the channel_user" do
      channel_user = channel_user_fixture()
      assert {:ok, %ChannelUser{}} = Accounts.delete_channel_user(channel_user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_channel_user!(channel_user.id) end
    end

    test "change_channel_user/1 returns a channel_user changeset" do
      channel_user = channel_user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_channel_user(channel_user)
    end
  end
end
