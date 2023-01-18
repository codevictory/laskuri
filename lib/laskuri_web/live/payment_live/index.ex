defmodule LaskuriWeb.PaymentLive.Index do
  use LaskuriWeb, :live_view

  alias Laskuri.MonthlyEntries
  alias Laskuri.MonthlyEntries.Payment

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :payments, list_payments())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Payment")
    |> assign(:payment, MonthlyEntries.get_payment!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Payment")
    |> assign(:payment, %Payment{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Payments")
    |> assign(:payment, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    payment = MonthlyEntries.get_payment!(id)
    {:ok, _} = MonthlyEntries.delete_payment(payment)

    {:noreply, assign(socket, :payments, list_payments())}
  end

  defp list_payments do
    MonthlyEntries.list_payments()
  end
end
