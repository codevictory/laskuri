defmodule Laskuri.Repo.Migrations.SeparatePaymentMonthlyFees do
  use Ecto.Migration

  def change do
    alter table(:payments) do
      add(:electricity_monthly_fee, :decimal)
      add(:transfer_monthly_fee, :decimal)
    end
  end
end
