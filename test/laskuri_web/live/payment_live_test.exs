defmodule LaskuriWeb.PaymentLiveTest do
  use LaskuriWeb.ConnCase

  import Phoenix.LiveViewTest
  import Laskuri.MonthlyEntriesFixtures

  @create_attrs %{accounting: "120.5", bank_transactions: "120.5", electricity: "120.5", fire_insurance: "120.5", heating: "120.5", interest: "120.5", misc_expenses: "120.5", month: 42, property_tax: "120.5", transfer: "120.5", waste_disposal: "120.5", water: "120.5", year: 42}
  @update_attrs %{accounting: "456.7", bank_transactions: "456.7", electricity: "456.7", fire_insurance: "456.7", heating: "456.7", interest: "456.7", misc_expenses: "456.7", month: 43, property_tax: "456.7", transfer: "456.7", waste_disposal: "456.7", water: "456.7", year: 43}
  @invalid_attrs %{accounting: nil, bank_transactions: nil, electricity: nil, fire_insurance: nil, heating: nil, interest: nil, misc_expenses: nil, month: nil, property_tax: nil, transfer: nil, waste_disposal: nil, water: nil, year: nil}

  defp create_payment(_) do
    payment = payment_fixture()
    %{payment: payment}
  end

  describe "Index" do
    setup [:create_payment]

    test "lists all payments", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.payment_index_path(conn, :index))

      assert html =~ "Listing Payments"
    end

    test "saves new payment", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.payment_index_path(conn, :index))

      assert index_live |> element("a", "New Payment") |> render_click() =~
               "New Payment"

      assert_patch(index_live, Routes.payment_index_path(conn, :new))

      assert index_live
             |> form("#payment-form", payment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#payment-form", payment: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.payment_index_path(conn, :index))

      assert html =~ "Payment created successfully"
    end

    test "updates payment in listing", %{conn: conn, payment: payment} do
      {:ok, index_live, _html} = live(conn, Routes.payment_index_path(conn, :index))

      assert index_live |> element("#payment-#{payment.id} a", "Edit") |> render_click() =~
               "Edit Payment"

      assert_patch(index_live, Routes.payment_index_path(conn, :edit, payment))

      assert index_live
             |> form("#payment-form", payment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#payment-form", payment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.payment_index_path(conn, :index))

      assert html =~ "Payment updated successfully"
    end

    test "deletes payment in listing", %{conn: conn, payment: payment} do
      {:ok, index_live, _html} = live(conn, Routes.payment_index_path(conn, :index))

      assert index_live |> element("#payment-#{payment.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#payment-#{payment.id}")
    end
  end

  describe "Show" do
    setup [:create_payment]

    test "displays payment", %{conn: conn, payment: payment} do
      {:ok, _show_live, html} = live(conn, Routes.payment_show_path(conn, :show, payment))

      assert html =~ "Show Payment"
    end

    test "updates payment within modal", %{conn: conn, payment: payment} do
      {:ok, show_live, _html} = live(conn, Routes.payment_show_path(conn, :show, payment))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Payment"

      assert_patch(show_live, Routes.payment_show_path(conn, :edit, payment))

      assert show_live
             |> form("#payment-form", payment: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#payment-form", payment: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.payment_show_path(conn, :show, payment))

      assert html =~ "Payment updated successfully"
    end
  end
end
