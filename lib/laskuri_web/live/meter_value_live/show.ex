defmodule LaskuriWeb.MeterValueLive.Show do
  use LaskuriWeb, :live_view

  alias Laskuri.MonthlyEntries

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:meter_value, MonthlyEntries.get_meter_value!(id))}
  end

  defp page_title(:show), do: "Show Meter value"
  defp page_title(:edit), do: "Edit Meter value"
end
