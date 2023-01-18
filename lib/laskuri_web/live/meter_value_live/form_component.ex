defmodule LaskuriWeb.MeterValueLive.FormComponent do
  use LaskuriWeb, :live_component

  alias Laskuri.MonthlyEntries

  @impl true
  def update(%{meter_value: meter_value} = assigns, socket) do
    changeset = MonthlyEntries.change_meter_value(meter_value)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"meter_value" => meter_value_params}, socket) do
    changeset =
      socket.assigns.meter_value
      |> MonthlyEntries.change_meter_value(meter_value_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"meter_value" => meter_value_params}, socket) do
    save_meter_value(socket, socket.assigns.action, meter_value_params)
  end

  defp save_meter_value(socket, :edit, meter_value_params) do
    case MonthlyEntries.update_meter_value(socket.assigns.meter_value, meter_value_params) do
      {:ok, _meter_value} ->
        {:noreply,
         socket
         |> put_flash(:info, "Meter value updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_meter_value(socket, :new, meter_value_params) do
    case MonthlyEntries.create_meter_value(meter_value_params) do
      {:ok, _meter_value} ->
        {:noreply,
         socket
         |> put_flash(:info, "Meter value created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
