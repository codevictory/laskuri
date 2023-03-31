defmodule Laskuri.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add(:year, :integer)
      add(:month, :integer)
      add(:electricity, :decimal)
      add(:transfer, :decimal)
      add(:bank_transactions, :decimal)
      add(:water, :decimal)
      add(:waste_disposal, :decimal)
      add(:heating, :decimal)
      add(:property_tax, :decimal)
      add(:accounting, :decimal)
      add(:fire_insurance, :decimal)
      add(:interest, :decimal)
      add(:misc_expenses, :decimal)

      timestamps()
    end
  end
end
