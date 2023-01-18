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

  describe "payments" do
    alias Laskuri.MonthlyEntries.Payment

    import Laskuri.MonthlyEntriesFixtures

    @invalid_attrs %{accounting: nil, bank_transactions: nil, electricity: nil, fire_insurance: nil, heating: nil, interest: nil, misc_expenses: nil, month: nil, property_tax: nil, transfer: nil, waste_disposal: nil, water: nil, year: nil}

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert MonthlyEntries.list_payments() == [payment]
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert MonthlyEntries.get_payment!(payment.id) == payment
    end

    test "create_payment/1 with valid data creates a payment" do
      valid_attrs = %{accounting: "120.5", bank_transactions: "120.5", electricity: "120.5", fire_insurance: "120.5", heating: "120.5", interest: "120.5", misc_expenses: "120.5", month: 42, property_tax: "120.5", transfer: "120.5", waste_disposal: "120.5", water: "120.5", year: 42}

      assert {:ok, %Payment{} = payment} = MonthlyEntries.create_payment(valid_attrs)
      assert payment.accounting == Decimal.new("120.5")
      assert payment.bank_transactions == Decimal.new("120.5")
      assert payment.electricity == Decimal.new("120.5")
      assert payment.fire_insurance == Decimal.new("120.5")
      assert payment.heating == Decimal.new("120.5")
      assert payment.interest == Decimal.new("120.5")
      assert payment.misc_expenses == Decimal.new("120.5")
      assert payment.month == 42
      assert payment.property_tax == Decimal.new("120.5")
      assert payment.transfer == Decimal.new("120.5")
      assert payment.waste_disposal == Decimal.new("120.5")
      assert payment.water == Decimal.new("120.5")
      assert payment.year == 42
    end

    test "create_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MonthlyEntries.create_payment(@invalid_attrs)
    end

    test "update_payment/2 with valid data updates the payment" do
      payment = payment_fixture()
      update_attrs = %{accounting: "456.7", bank_transactions: "456.7", electricity: "456.7", fire_insurance: "456.7", heating: "456.7", interest: "456.7", misc_expenses: "456.7", month: 43, property_tax: "456.7", transfer: "456.7", waste_disposal: "456.7", water: "456.7", year: 43}

      assert {:ok, %Payment{} = payment} = MonthlyEntries.update_payment(payment, update_attrs)
      assert payment.accounting == Decimal.new("456.7")
      assert payment.bank_transactions == Decimal.new("456.7")
      assert payment.electricity == Decimal.new("456.7")
      assert payment.fire_insurance == Decimal.new("456.7")
      assert payment.heating == Decimal.new("456.7")
      assert payment.interest == Decimal.new("456.7")
      assert payment.misc_expenses == Decimal.new("456.7")
      assert payment.month == 43
      assert payment.property_tax == Decimal.new("456.7")
      assert payment.transfer == Decimal.new("456.7")
      assert payment.waste_disposal == Decimal.new("456.7")
      assert payment.water == Decimal.new("456.7")
      assert payment.year == 43
    end

    test "update_payment/2 with invalid data returns error changeset" do
      payment = payment_fixture()
      assert {:error, %Ecto.Changeset{}} = MonthlyEntries.update_payment(payment, @invalid_attrs)
      assert payment == MonthlyEntries.get_payment!(payment.id)
    end

    test "delete_payment/1 deletes the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{}} = MonthlyEntries.delete_payment(payment)
      assert_raise Ecto.NoResultsError, fn -> MonthlyEntries.get_payment!(payment.id) end
    end

    test "change_payment/1 returns a payment changeset" do
      payment = payment_fixture()
      assert %Ecto.Changeset{} = MonthlyEntries.change_payment(payment)
    end
  end
end
