defmodule Laskuri.MonthlyEntries.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :accounting, :decimal, default: 0
    field :bank_transactions, :decimal, default: 0
    field :electricity, :decimal, default: 0
    field :electricity_monthly_fee, :decimal, default: 0
    field :fire_insurance, :decimal, default: 0
    field :heating, :decimal, default: 0
    field :interest, :decimal, default: 0
    field :misc_expenses, :decimal, default: 0
    field :month, :integer
    field :property_tax, :decimal, default: 0
    field :transfer, :decimal, default: 0
    field :transfer_monthly_fee, :decimal, default: 0
    field :waste_disposal, :decimal, default: 0
    field :water, :decimal, default: 0
    field :year, :integer
    field :waste_water, :decimal, default: 0

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [
      :year,
      :month,
      :electricity,
      :electricity_monthly_fee,
      :transfer,
      :transfer_monthly_fee,
      :bank_transactions,
      :waste_water,
      :water,
      :waste_disposal,
      :heating,
      :property_tax,
      :accounting,
      :fire_insurance,
      :interest,
      :misc_expenses
    ])
    |> validate_required([:year, :month])
  end
end
