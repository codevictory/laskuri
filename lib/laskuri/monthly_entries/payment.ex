defmodule Laskuri.MonthlyEntries.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :accounting, :decimal
    field :bank_transactions, :decimal
    field :electricity, :decimal
    field :fire_insurance, :decimal
    field :heating, :decimal
    field :interest, :decimal
    field :misc_expenses, :decimal
    field :month, :integer
    field :property_tax, :decimal
    field :transfer, :decimal
    field :waste_disposal, :decimal
    field :water, :decimal
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [
      :year,
      :month,
      :electricity,
      :transfer,
      :bank_transactions,
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
