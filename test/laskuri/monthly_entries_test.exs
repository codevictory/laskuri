defmodule Laskuri.MonthlyEntriesTest do
  use Laskuri.DataCase

  alias Laskuri.MonthlyEntries

  describe "meter_values" do
    alias Laskuri.MonthlyEntries.MeterValue

    import Laskuri.MonthlyEntriesFixtures

    @invalid_attrs %{cellar: nil, day: nil, kitchen: nil, month: nil, sauna: nil, shop: nil, upstairs: nil, year: nil}

    test "list_meter_values/0 returns all meter_values" do
      meter_value = meter_value_fixture()
      assert MonthlyEntries.list_meter_values() == [meter_value]
    end

    test "get_meter_value!/1 returns the meter_value with given id" do
      meter_value = meter_value_fixture()
      assert MonthlyEntries.get_meter_value!(meter_value.id) == meter_value
    end

    test "create_meter_value/1 with valid data creates a meter_value" do
      valid_attrs = %{cellar: "120.5", day: 42, kitchen: "120.5", month: 42, sauna: "120.5", shop: "120.5", upstairs: "120.5", year: 42}

      assert {:ok, %MeterValue{} = meter_value} = MonthlyEntries.create_meter_value(valid_attrs)
      assert meter_value.cellar == Decimal.new("120.5")
      assert meter_value.day == 42
      assert meter_value.kitchen == Decimal.new("120.5")
      assert meter_value.month == 42
      assert meter_value.sauna == Decimal.new("120.5")
      assert meter_value.shop == Decimal.new("120.5")
      assert meter_value.upstairs == Decimal.new("120.5")
      assert meter_value.year == 42
    end

    test "create_meter_value/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MonthlyEntries.create_meter_value(@invalid_attrs)
    end

    test "update_meter_value/2 with valid data updates the meter_value" do
      meter_value = meter_value_fixture()
      update_attrs = %{cellar: "456.7", day: 43, kitchen: "456.7", month: 43, sauna: "456.7", shop: "456.7", upstairs: "456.7", year: 43}

      assert {:ok, %MeterValue{} = meter_value} = MonthlyEntries.update_meter_value(meter_value, update_attrs)
      assert meter_value.cellar == Decimal.new("456.7")
      assert meter_value.day == 43
      assert meter_value.kitchen == Decimal.new("456.7")
      assert meter_value.month == 43
      assert meter_value.sauna == Decimal.new("456.7")
      assert meter_value.shop == Decimal.new("456.7")
      assert meter_value.upstairs == Decimal.new("456.7")
      assert meter_value.year == 43
    end

    test "update_meter_value/2 with invalid data returns error changeset" do
      meter_value = meter_value_fixture()
      assert {:error, %Ecto.Changeset{}} = MonthlyEntries.update_meter_value(meter_value, @invalid_attrs)
      assert meter_value == MonthlyEntries.get_meter_value!(meter_value.id)
    end

    test "delete_meter_value/1 deletes the meter_value" do
      meter_value = meter_value_fixture()
      assert {:ok, %MeterValue{}} = MonthlyEntries.delete_meter_value(meter_value)
      assert_raise Ecto.NoResultsError, fn -> MonthlyEntries.get_meter_value!(meter_value.id) end
    end

    test "change_meter_value/1 returns a meter_value changeset" do
      meter_value = meter_value_fixture()
      assert %Ecto.Changeset{} = MonthlyEntries.change_meter_value(meter_value)
    end
  end
end
