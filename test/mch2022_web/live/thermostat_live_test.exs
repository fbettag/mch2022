defmodule Mch2022Web.ThermostatLiveTest do
  use Mch2022Web.ConnCase

  import Phoenix.LiveViewTest
  import Mch2022.MeasurementsFixtures

  @create_attrs %{name: "some name", temperature: 42}
  @update_attrs %{name: "some updated name", temperature: 43}
  @invalid_attrs %{name: nil, temperature: nil}

  defp create_thermostat(_) do
    thermostat = thermostat_fixture()
    %{thermostat: thermostat}
  end

  describe "Index" do
    setup [:create_thermostat]

    test "lists all thermostats", %{conn: conn, thermostat: thermostat} do
      {:ok, _index_live, html} = live(conn, Routes.thermostat_index_path(conn, :index))

      assert html =~ "Listing Thermostats"
      assert html =~ thermostat.name
    end

    test "saves new thermostat", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.thermostat_index_path(conn, :index))

      assert index_live |> element("a", "New Thermostat") |> render_click() =~
               "New Thermostat"

      assert_patch(index_live, Routes.thermostat_index_path(conn, :new))

      assert index_live
             |> form("#thermostat-form", thermostat: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#thermostat-form", thermostat: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.thermostat_index_path(conn, :index))

      assert html =~ "Thermostat created successfully"
      assert html =~ "some name"
    end

    test "updates thermostat in listing", %{conn: conn, thermostat: thermostat} do
      {:ok, index_live, _html} = live(conn, Routes.thermostat_index_path(conn, :index))

      assert index_live |> element("#thermostat-#{thermostat.id} a", "Edit") |> render_click() =~
               "Edit Thermostat"

      assert_patch(index_live, Routes.thermostat_index_path(conn, :edit, thermostat))

      assert index_live
             |> form("#thermostat-form", thermostat: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#thermostat-form", thermostat: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.thermostat_index_path(conn, :index))

      assert html =~ "Thermostat updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes thermostat in listing", %{conn: conn, thermostat: thermostat} do
      {:ok, index_live, _html} = live(conn, Routes.thermostat_index_path(conn, :index))

      assert index_live |> element("#thermostat-#{thermostat.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#thermostat-#{thermostat.id}")
    end
  end

  describe "Show" do
    setup [:create_thermostat]

    test "displays thermostat", %{conn: conn, thermostat: thermostat} do
      {:ok, _show_live, html} = live(conn, Routes.thermostat_show_path(conn, :show, thermostat))

      assert html =~ "Show Thermostat"
      assert html =~ thermostat.name
    end

    test "increase/decrease thermostat", %{conn: conn, thermostat: thermostat} do
      {:ok, show_live, html} = live(conn, Routes.thermostat_show_path(conn, :show, thermostat))

      assert html =~ "Show Thermostat"
      assert show_live |> element("#temperature") |> render() =~ "42"

      show_live |> element("#incr") |> render_click()
      assert show_live |> element("#temperature") |> render() =~ "43"

      show_live |> element("#decr") |> render_click()
      assert show_live |> element("#temperature") |> render() =~ "42"
    end

    test "updates thermostat within modal", %{conn: conn, thermostat: thermostat} do
      {:ok, show_live, _html} = live(conn, Routes.thermostat_show_path(conn, :show, thermostat))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Thermostat"

      assert_patch(show_live, Routes.thermostat_show_path(conn, :edit, thermostat))

      assert show_live
             |> form("#thermostat-form", thermostat: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#thermostat-form", thermostat: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.thermostat_show_path(conn, :show, thermostat))

      assert html =~ "Thermostat updated successfully"
      assert html =~ "some updated name"
    end
  end
end
