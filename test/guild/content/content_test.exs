defmodule Guild.ContentTest do
  use Guild.DataCase

  alias Guild.Content

  describe "messages" do
    alias Guild.Content.Message

    @valid_attrs %{body: "some body", channel_id: 42, from: 42}
    @update_attrs %{body: "some updated body", channel_id: 43, from: 43}
    @invalid_attrs %{body: nil, channel_id: nil, from: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Content.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Content.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Content.create_message(@valid_attrs)
      assert message.body == "some body"
      assert message.channel_id == 42
      assert message.from == 42
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, message} = Content.update_message(message, @update_attrs)
      assert %Message{} = message
      assert message.body == "some updated body"
      assert message.channel_id == 43
      assert message.from == 43
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_message(message, @invalid_attrs)
      assert message == Content.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Content.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Content.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Content.change_message(message)
    end
  end
end
