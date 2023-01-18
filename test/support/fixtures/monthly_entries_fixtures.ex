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
end
