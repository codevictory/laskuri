defmodule Laskuri.MonthlyEntries.MeterValue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meter_values" do
    field :cellar, :decimal
    field :day, :integer
    field :kitchen, :decimal
    field :month, :integer
    field :sauna, :decimal
    field :shop, :decimal
    field :upstairs, :decimal
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(meter_value, attrs) do
    meter_value
    |> cast(attrs, [:year, :month, :upstairs, :kitchen, :shop, :cellar, :sauna, :day])
    |> validate_required([:year, :month, :upstairs, :kitchen, :shop, :cellar, :sauna, :day])
  end
end
