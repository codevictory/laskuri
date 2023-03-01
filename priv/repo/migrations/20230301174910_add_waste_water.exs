defmodule Laskuri.Repo.Migrations.AddWasteWater do
  use Ecto.Migration

  def change do
    alter table(:payments) do
      add(:waste_water, :decimal)
    end
  end
end
