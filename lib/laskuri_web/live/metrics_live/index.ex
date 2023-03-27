defmodule LaskuriWeb.MetricsLive.Index do
  use LaskuriWeb, :live_view

  alias Laskuri.MonthlyEntries

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:title, "Valitse kuukausi")
    |> assign(:months, MonthlyEntries.get_submitted_months())
  end

  defp apply_action(socket, :display, %{"month" => month}) do
    socket
    |> assign(:page_title, month)
    |> assign(:months, MonthlyEntries.get_submitted_months())
    |> assign(:meter_value, MonthlyEntries.get_monthly_values(month))
  end
end
