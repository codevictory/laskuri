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
    |> Repo.all()
  end

  def get_monthly_values(month) do
    Repo.one(from m in MeterValue, where: m.checked == ^month)
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
    new = get_monthly_values(month)

    prev =
      case get_monthly_values(parse_previous_month(month)) do
        nil ->
          Map.new([
            {:upstairs, Decimal.new(0)},
            {:kitchen, Decimal.new(0)},
            {:cellar, Decimal.new(0)},
            {:sauna, Decimal.new(0)},
            {:shop, Decimal.new(0)},
            {:checked, Date.new(1, 1, 1)}
          ])

        %MeterValue{} = values ->
          values
      end

    case get_monthly_payments(month) do
      nil ->
        %{viveta: 0, osuusvoima: 0}

      %Payment{} = payments ->
        upstairs = Decimal.sub(new.upstairs, prev.upstairs)
        kitchen = Decimal.sub(new.kitchen, prev.kitchen)
        shop = Decimal.sub(new.shop, prev.shop)
        cellar = Decimal.sub(new.cellar, prev.cellar)
        sauna = Decimal.sub(new.sauna, prev.sauna)

        sum =
          Decimal.add(upstairs, kitchen)
          |> Decimal.add(shop)
          |> Decimal.add(shop)
          |> Decimal.add(cellar)
          |> Decimal.add(sauna)

        # percentages
        viveta_p = Decimal.add(upstairs, sauna) |> Decimal.div(sum)

        osuusvoima_p = Decimal.add(kitchen, shop) |> Decimal.div(sum)
        shared_p = Decimal.div(cellar, sum)

        energy_price =
          Decimal.add(payments.electricity, payments.transfer)
          |> Decimal.sub(payments.electricity_monthly_fee)
          |> Decimal.sub(payments.transfer_monthly_fee)

        # fees according to the usage
        viveta_f = Decimal.mult(viveta_p, energy_price)
        osuusvoima_f = Decimal.mult(osuusvoima_p, energy_price)
        shared_f = Decimal.mult(shared_p, energy_price)

        # fees split evenly
        split_evenly =
          Decimal.add(payments.bank_transactions, payments.waste_water)
          |> Decimal.add(payments.water)
          |> Decimal.add(payments.waste_disposal)
          |> Decimal.add(payments.heating)
          |> Decimal.add(payments.property_tax)
          |> Decimal.add(payments.accounting)
          |> Decimal.add(payments.fire_insurance)
          |> Decimal.add(payments.interest)
          |> Decimal.add(payments.misc_expenses)
          |> Decimal.add(shared_f)

        viveta_final = Decimal.add(viveta_f, split_evenly) |> Decimal.div(2)
        osuusvoima_final = Decimal.add(osuusvoima_f, split_evenly) |> Decimal.div(2)

        %{viveta: viveta_final, osuusvoima: osuusvoima_final}
    end
  end

  defp parse_previous_month(month) do
    parsed_date = Date.from_iso8601!(month)

    if parsed_date.month == 1 do
      Date.to_iso8601(%{parsed_date | year: parsed_date.year - 1, month: 12})
    else
      Date.to_iso8601(%{parsed_date | month: parsed_date.month - 1})
    end
  end
end
