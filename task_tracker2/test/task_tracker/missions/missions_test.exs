defmodule TaskTracker.MissionsTest do
  use TaskTracker.DataCase

  alias TaskTracker.Missions

  describe "tasks" do
    alias TaskTracker.Missions.Task

    @valid_attrs %{completed: true, description: "some description", time: 42, title: "some title"}
    @update_attrs %{completed: false, description: "some updated description", time: 43, title: "some updated title"}
    @invalid_attrs %{completed: nil, description: nil, time: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Missions.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Missions.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Missions.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Missions.create_task(@valid_attrs)
      assert task.completed == true
      assert task.description == "some description"
      assert task.time == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Missions.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Missions.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completed == false
      assert task.description == "some updated description"
      assert task.time == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Missions.update_task(task, @invalid_attrs)
      assert task == Missions.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Missions.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Missions.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Missions.change_task(task)
    end
  end

  describe "manages" do
    alias TaskTracker.Missions.Manage

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def manage_fixture(attrs \\ %{}) do
      {:ok, manage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Missions.create_manage()

      manage
    end

    test "list_manages/0 returns all manages" do
      manage = manage_fixture()
      assert Missions.list_manages() == [manage]
    end

    test "get_manage!/1 returns the manage with given id" do
      manage = manage_fixture()
      assert Missions.get_manage!(manage.id) == manage
    end

    test "create_manage/1 with valid data creates a manage" do
      assert {:ok, %Manage{} = manage} = Missions.create_manage(@valid_attrs)
    end

    test "create_manage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Missions.create_manage(@invalid_attrs)
    end

    test "update_manage/2 with valid data updates the manage" do
      manage = manage_fixture()
      assert {:ok, manage} = Missions.update_manage(manage, @update_attrs)
      assert %Manage{} = manage
    end

    test "update_manage/2 with invalid data returns error changeset" do
      manage = manage_fixture()
      assert {:error, %Ecto.Changeset{}} = Missions.update_manage(manage, @invalid_attrs)
      assert manage == Missions.get_manage!(manage.id)
    end

    test "delete_manage/1 deletes the manage" do
      manage = manage_fixture()
      assert {:ok, %Manage{}} = Missions.delete_manage(manage)
      assert_raise Ecto.NoResultsError, fn -> Missions.get_manage!(manage.id) end
    end

    test "change_manage/1 returns a manage changeset" do
      manage = manage_fixture()
      assert %Ecto.Changeset{} = Missions.change_manage(manage)
    end
  end

  describe "timeblocks" do
    alias TaskTracker.Missions.Timeblock

    @valid_attrs %{end_time: "2010-04-17 14:00:00.000000Z", start_time: "2010-04-17 14:00:00.000000Z"}
    @update_attrs %{end_time: "2011-05-18 15:01:01.000000Z", start_time: "2011-05-18 15:01:01.000000Z"}
    @invalid_attrs %{end_time: nil, start_time: nil}

    def timeblock_fixture(attrs \\ %{}) do
      {:ok, timeblock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Missions.create_timeblock()

      timeblock
    end

    test "list_timeblocks/0 returns all timeblocks" do
      timeblock = timeblock_fixture()
      assert Missions.list_timeblocks() == [timeblock]
    end

    test "get_timeblock!/1 returns the timeblock with given id" do
      timeblock = timeblock_fixture()
      assert Missions.get_timeblock!(timeblock.id) == timeblock
    end

    test "create_timeblock/1 with valid data creates a timeblock" do
      assert {:ok, %Timeblock{} = timeblock} = Missions.create_timeblock(@valid_attrs)
      assert timeblock.end_time == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert timeblock.start_time == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
    end

    test "create_timeblock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Missions.create_timeblock(@invalid_attrs)
    end

    test "update_timeblock/2 with valid data updates the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, timeblock} = Missions.update_timeblock(timeblock, @update_attrs)
      assert %Timeblock{} = timeblock
      assert timeblock.end_time == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert timeblock.start_time == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
    end

    test "update_timeblock/2 with invalid data returns error changeset" do
      timeblock = timeblock_fixture()
      assert {:error, %Ecto.Changeset{}} = Missions.update_timeblock(timeblock, @invalid_attrs)
      assert timeblock == Missions.get_timeblock!(timeblock.id)
    end

    test "delete_timeblock/1 deletes the timeblock" do
      timeblock = timeblock_fixture()
      assert {:ok, %Timeblock{}} = Missions.delete_timeblock(timeblock)
      assert_raise Ecto.NoResultsError, fn -> Missions.get_timeblock!(timeblock.id) end
    end

    test "change_timeblock/1 returns a timeblock changeset" do
      timeblock = timeblock_fixture()
      assert %Ecto.Changeset{} = Missions.change_timeblock(timeblock)
    end
  end
end
