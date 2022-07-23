defmodule Mch2022.MeasurementsTest do
  use Mch2022.DataCase

  alias Mch2022.Measurements

  describe "thermostats" do
    alias Mch2022.Measurements.Thermostat

    import Mch2022.MeasurementsFixtures

    @invalid_attrs %{name: nil, temperature: nil}

    test "list_thermostats/0 returns all thermostats" do
      thermostat = thermostat_fixture()
      assert Measurements.list_thermostats() == [thermostat]
    end

    test "get_thermostat!/1 returns the thermostat with given id" do
      thermostat = thermostat_fixture()
      assert Measurements.get_thermostat!(thermostat.id) == thermostat
    end

    test "create_thermostat/1 with valid data creates a thermostat" do
      valid_attrs = %{name: "some name", temperature: 42}

      assert {:ok, %Thermostat{} = thermostat} = Measurements.create_thermostat(valid_attrs)
      assert thermostat.name == "some name"
      assert thermostat.temperature == 42
    end

    test "create_thermostat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Measurements.create_thermostat(@invalid_attrs)
    end

    test "update_thermostat/2 with valid data updates the thermostat" do
      thermostat = thermostat_fixture()
      update_attrs = %{name: "some updated name", temperature: 43}

      assert {:ok, %Thermostat{} = thermostat} =
               Measurements.update_thermostat(thermostat, update_attrs)

      assert thermostat.name == "some updated name"
      assert thermostat.temperature == 43
    end

    test "update_thermostat/2 with invalid data returns error changeset" do
      thermostat = thermostat_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Measurements.update_thermostat(thermostat, @invalid_attrs)

      assert thermostat == Measurements.get_thermostat!(thermostat.id)
    end

    test "delete_thermostat/1 deletes the thermostat" do
      thermostat = thermostat_fixture()
      assert {:ok, %Thermostat{}} = Measurements.delete_thermostat(thermostat)
      assert_raise Ecto.NoResultsError, fn -> Measurements.get_thermostat!(thermostat.id) end
    end

    test "change_thermostat/1 returns a thermostat changeset" do
      thermostat = thermostat_fixture()
      assert %Ecto.Changeset{} = Measurements.change_thermostat(thermostat)
    end
  end
end
