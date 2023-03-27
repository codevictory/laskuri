defmodule LaskuriWeb.MeterValueLive.Index do
  use LaskuriWeb, :live_view

  alias Laskuri.MonthlyEntries
  alias Laskuri.MonthlyEntries.MeterValue

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :meter_values, list_meter_values())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:modal_title, "Muokkaa sähkölukemia")
    |> assign(:page_title, "Mittarilukemat")
    |> assign(:meter_value, MonthlyEntries.get_meter_value!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:modal_title, "Lisää sähkölukemat")
    |> assign(:page_title, "Mittarilukemat")
    |> assign(:meter_value, %MeterValue{checked: DateTime.utc_now()})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Mittarilukemat")
    |> assign(:meter_value, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    meter_value = MonthlyEntries.get_meter_value!(id)
    {:ok, _} = MonthlyEntries.delete_meter_value(meter_value)

    {:noreply, assign(socket, :meter_values, list_meter_values())}
  end

  defp list_meter_values do
    MonthlyEntries.list_meter_values()
  end
end
