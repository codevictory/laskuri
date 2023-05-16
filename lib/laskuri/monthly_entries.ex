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

  def get_submitted_months() do
    from(m in MeterValue, select: m.checked())
    |> order_by(desc: :checked)
    |> Repo.all()
    |> List.delete_at(0)
  end

  def get_monthly_values(month) do
    Repo.one(from m in MeterValue, where: m.checked == ^month)
  end

  def get_monthly_usage(month) do
    end_of_month = get_monthly_values(parse_next_month(month))

    start_of_month = get_monthly_values(month)

    Map.new([
      {:upstairs, Decimal.sub(end_of_month.upstairs, start_of_month.upstairs)},
      {:kitchen, Decimal.sub(end_of_month.kitchen, start_of_month.kitchen)},
      {:cellar, Decimal.sub(end_of_month.cellar, start_of_month.cellar)},
      {:sauna, Decimal.sub(end_of_month.sauna, start_of_month.sauna)},
      {:shop, Decimal.sub(end_of_month.shop, start_of_month.shop)},
      {:checked, end_of_month.checked}
    ])
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

  def get_monthly_payments(month) do
    parsed_date = Date.from_iso8601!(month)

    Repo.one(
      from p in Payment,
        where: p.year == ^parsed_date.year and p.month == ^parsed_date.month
    )
  end

  def get_monthly_fees(month) do
    case get_monthly_payments(month) do
      nil ->
        %{viveta: Decimal.new(0), osuusvoima: Decimal.new(0)}

      %Payment{} = payments ->
        usage = get_monthly_usage(month)

        sum =
          Decimal.add(usage.upstairs, usage.kitchen)
          |> Decimal.add(usage.shop)
          |> Decimal.add(usage.cellar)
          |> Decimal.add(usage.sauna)

        # percentages
        viveta_percentage = Decimal.add(usage.upstairs, usage.sauna) |> Decimal.div(sum)
        osuusvoima_percentage = Decimal.add(usage.kitchen, usage.shop) |> Decimal.div(sum)
        shared_percentage = Decimal.div(usage.cellar, sum)

        energy_price =
          Decimal.add(payments.electricity, payments.transfer)
          |> Decimal.sub(payments.electricity_monthly_fee)
          |> Decimal.sub(payments.transfer_monthly_fee)

        # fees according to the usage
        viveta_energy = Decimal.mult(viveta_percentage, energy_price)
        osuusvoima_energy = Decimal.mult(osuusvoima_percentage, energy_price)
        shared_energy = Decimal.mult(shared_percentage, energy_price)

        # fees split evenly
        split_evenly =
          Decimal.add(payments.bank_transactions, payments.waste_water)
          |> Decimal.add(payments.electricity_monthly_fee)
          |> Decimal.add(payments.transfer_monthly_fee)
          |> Decimal.add(payments.water)
          |> Decimal.add(payments.waste_disposal)
          |> Decimal.add(payments.heating)
          |> Decimal.add(payments.property_tax)
          |> Decimal.add(payments.accounting)
          |> Decimal.add(payments.fire_insurance)
          |> Decimal.add(payments.interest)
          |> Decimal.add(payments.misc_expenses)
          |> Decimal.add(shared_energy)

        viveta_final = Decimal.div(split_evenly, 2) |> Decimal.add(viveta_energy)
        osuusvoima_final = Decimal.div(split_evenly, 2) |> Decimal.add(osuusvoima_energy)

        %{viveta: Decimal.round(viveta_final, 2), osuusvoima: Decimal.round(osuusvoima_final, 2)}
    end
  end

  defp parse_next_month(month) do
    parsed_date = Date.from_iso8601!(month)

    if parsed_date.month == 12 do
      Date.to_iso8601(%{parsed_date | year: parsed_date.year + 1, month: 1})
    else
      Date.to_iso8601(%{parsed_date | month: parsed_date.month + 1})
    end
  end
end
