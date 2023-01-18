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

  alias Laskuri.MonthlyEntries.Payment

  @doc """
  Returns the list of payments.

  ## Examples

      iex> list_payments()
      [%Payment{}, ...]

  """
  def list_payments do
    Repo.all(Payment)
  end

  @doc """
  Gets a single payment.

  Raises `Ecto.NoResultsError` if the Payment does not exist.

  ## Examples

      iex> get_payment!(123)
      %Payment{}

      iex> get_payment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_payment!(id), do: Repo.get!(Payment, id)

  @doc """
  Creates a payment.

  ## Examples

      iex> create_payment(%{field: value})
      {:ok, %Payment{}}

      iex> create_payment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_payment(attrs \\ %{}) do
    %Payment{}
    |> Payment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a payment.

  ## Examples

      iex> update_payment(payment, %{field: new_value})
      {:ok, %Payment{}}

      iex> update_payment(payment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_payment(%Payment{} = payment, attrs) do
    payment
    |> Payment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a payment.

  ## Examples

      iex> delete_payment(payment)
      {:ok, %Payment{}}

      iex> delete_payment(payment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_payment(%Payment{} = payment) do
    Repo.delete(payment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking payment changes.

  ## Examples

      iex> change_payment(payment)
      %Ecto.Changeset{data: %Payment{}}

  """
  def change_payment(%Payment{} = payment, attrs \\ %{}) do
    Payment.changeset(payment, attrs)
  end
end
