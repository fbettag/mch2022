defmodule Mch2022Web.ThermostatLive.Index do
  use Mch2022Web, :live_view

  alias Mch2022.Measurements
  alias Mch2022.Measurements.Thermostat

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :thermostats, list_thermostats())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Thermostat")
    |> assign(:thermostat, Measurements.get_thermostat!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Thermostat")
    |> assign(:thermostat, %Thermostat{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Thermostats")
    |> assign(:thermostat, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    thermostat = Measurements.get_thermostat!(id)
    {:ok, _} = Measurements.delete_thermostat(thermostat)

    {:noreply, assign(socket, :thermostats, list_thermostats())}
  end

  defp list_thermostats do
    Measurements.list_thermostats()
  end
end
