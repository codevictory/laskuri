defmodule Laskuri.MonthlyEntriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Laskuri.MonthlyEntries` context.
  """

  @doc """
  Generate a meter_value.
  """
  def meter_value_fixture(attrs \\ %{}) do
    {:ok, meter_value} =
      attrs
      |> Enum.into(%{
        cellar: "120.5",
        day: 42,
        kitchen: "120.5",
        month: 42,
        sauna: "120.5",
        shop: "120.5",
        upstairs: "120.5",
        year: 42
      })
      |> Laskuri.MonthlyEntries.create_meter_value()

    meter_value
  end

  @doc """
  Generate a payment.
  """
  def payment_fixture(attrs \\ %{}) do
    {:ok, payment} =
      attrs
      |> Enum.into(%{
        accounting: "120.5",
        bank_transactions: "120.5",
        electricity: "120.5",
        fire_insurance: "120.5",
        heating: "120.5",
        interest: "120.5",
        misc_expenses: "120.5",
        month: 42,
        property_tax: "120.5",
        transfer: "120.5",
        waste_disposal: "120.5",
        water: "120.5",
        year: 42
      })
      |> Laskuri.MonthlyEntries.create_payment()

    payment
  end
end
