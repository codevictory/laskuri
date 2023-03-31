defmodule Laskuri.Repo.Migrations.CreateMeterValues do
  use Ecto.Migration

  def change do
    create table(:meter_values) do
      add(:year, :integer)
      add(:month, :integer)
      add(:upstairs, :decimal)
      add(:kitchen, :decimal)
      add(:shop, :decimal)
      add(:cellar, :decimal)
      add(:sauna, :decimal)
      add(:day, :integer)

      timestamps()
    end
  end
end
