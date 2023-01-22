defmodule Laskuri.Repo.Migrations.ChangeMeterValuesDateType do
  use Ecto.Migration

  def change do
    alter table("meter_values") do
      add(:checked, :date)
      remove(:year)
      remove(:month)
      remove(:day)
    end
  end
end
