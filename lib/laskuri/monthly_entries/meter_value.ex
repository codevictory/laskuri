defmodule Laskuri.MonthlyEntries.MeterValue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meter_values" do
    field :checked, :date
    field :cellar, :decimal
    field :kitchen, :decimal
    field :sauna, :decimal
    field :shop, :decimal
    field :upstairs, :decimal

    timestamps()
  end

  @doc false
  def changeset(meter_value, attrs) do
    meter_value
    |> cast(attrs, [:checked, :upstairs, :kitchen, :shop, :cellar, :sauna])
    |> validate_required([:checked, :upstairs, :kitchen, :shop, :cellar, :sauna])
  end
end
