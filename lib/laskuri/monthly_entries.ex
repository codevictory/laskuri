defmodule Laskuri.MonthlyEntries do
  @moduledoc """
  The MonthlyEntries context.
  """

  import Ecto.Query, warn: false
  alias Laskuri.Repo

  alias Laskuri.MonthlyEntries.MeterValue

  @doc """
  Returns the list of meter_values.

  ## Examples

      iex> list_meter_values()
      [%MeterValue{}, ...]

  """
  def list_meter_values do
    Repo.all(MeterValue)
  end

  @doc """
  Gets a single meter_value.

  Raises `Ecto.NoResultsError` if the Meter value does not exist.

  ## Examples

      iex> get_meter_value!(123)
      %MeterValue{}

      iex> get_meter_value!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meter_value!(id), do: Repo.get!(MeterValue, id)

  @doc """
  Creates a meter_value.

  ## Examples

      iex> create_meter_value(%{field: value})
      {:ok, %MeterValue{}}

      iex> create_meter_value(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_meter_value(attrs \\ %{}) do
    %MeterValue{}
    |> MeterValue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a meter_value.

  ## Examples

      iex> update_meter_value(meter_value, %{field: new_value})
      {:ok, %MeterValue{}}

      iex> update_meter_value(meter_value, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_meter_value(%MeterValue{} = meter_value, attrs) do
    meter_value
    |> MeterValue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a meter_value.

  ## Examples

      iex> delete_meter_value(meter_value)
      {:ok, %MeterValue{}}

      iex> delete_meter_value(meter_value)
      {:error, %Ecto.Changeset{}}

  """
  def delete_meter_value(%MeterValue{} = meter_value) do
    Repo.delete(meter_value)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking meter_value changes.

  ## Examples

      iex> change_meter_value(meter_value)
      %Ecto.Changeset{data: %MeterValue{}}

  """
  def change_meter_value(%MeterValue{} = meter_value, attrs \\ %{}) do
    MeterValue.changeset(meter_value, attrs)
  end
end
