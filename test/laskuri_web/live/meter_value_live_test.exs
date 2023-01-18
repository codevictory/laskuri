defmodule LaskuriWeb.MeterValueLiveTest do
  use LaskuriWeb.ConnCase

  import Phoenix.LiveViewTest
  import Laskuri.MonthlyEntriesFixtures

  @create_attrs %{cellar: "120.5", day: 42, kitchen: "120.5", month: 42, sauna: "120.5", shop: "120.5", upstairs: "120.5", year: 42}
  @update_attrs %{cellar: "456.7", day: 43, kitchen: "456.7", month: 43, sauna: "456.7", shop: "456.7", upstairs: "456.7", year: 43}
  @invalid_attrs %{cellar: nil, day: nil, kitchen: nil, month: nil, sauna: nil, shop: nil, upstairs: nil, year: nil}

  defp create_meter_value(_) do
    meter_value = meter_value_fixture()
    %{meter_value: meter_value}
  end

  describe "Index" do
    setup [:create_meter_value]

    test "lists all meter_values", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.meter_value_index_path(conn, :index))

      assert html =~ "Listing Meter values"
    end

    test "saves new meter_value", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.meter_value_index_path(conn, :index))

      assert index_live |> element("a", "New Meter value") |> render_click() =~
               "New Meter value"

      assert_patch(index_live, Routes.meter_value_index_path(conn, :new))

      assert index_live
             |> form("#meter_value-form", meter_value: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#meter_value-form", meter_value: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.meter_value_index_path(conn, :index))

      assert html =~ "Meter value created successfully"
    end

    test "updates meter_value in listing", %{conn: conn, meter_value: meter_value} do
      {:ok, index_live, _html} = live(conn, Routes.meter_value_index_path(conn, :index))

      assert index_live |> element("#meter_value-#{meter_value.id} a", "Edit") |> render_click() =~
               "Edit Meter value"

      assert_patch(index_live, Routes.meter_value_index_path(conn, :edit, meter_value))

      assert index_live
             |> form("#meter_value-form", meter_value: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#meter_value-form", meter_value: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.meter_value_index_path(conn, :index))

      assert html =~ "Meter value updated successfully"
    end

    test "deletes meter_value in listing", %{conn: conn, meter_value: meter_value} do
      {:ok, index_live, _html} = live(conn, Routes.meter_value_index_path(conn, :index))

      assert index_live |> element("#meter_value-#{meter_value.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#meter_value-#{meter_value.id}")
    end
  end

  describe "Show" do
    setup [:create_meter_value]

    test "displays meter_value", %{conn: conn, meter_value: meter_value} do
      {:ok, _show_live, html} = live(conn, Routes.meter_value_show_path(conn, :show, meter_value))

      assert html =~ "Show Meter value"
    end

    test "updates meter_value within modal", %{conn: conn, meter_value: meter_value} do
      {:ok, show_live, _html} = live(conn, Routes.meter_value_show_path(conn, :show, meter_value))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Meter value"

      assert_patch(show_live, Routes.meter_value_show_path(conn, :edit, meter_value))

      assert show_live
             |> form("#meter_value-form", meter_value: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#meter_value-form", meter_value: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.meter_value_show_path(conn, :show, meter_value))

      assert html =~ "Meter value updated successfully"
    end
  end
end
