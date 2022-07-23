defmodule Mch2022Web.ThermostatLive.Show do
  use Mch2022Web, :live_view

  alias Mch2022.Measurements

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    thermostat = Measurements.get_thermostat!(id)
    if connected?(socket), do: Phoenix.PubSub.subscribe(Mch2022.PubSub, "thermostat:#{id}")

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:thermostat, thermostat)}
  end

  @impl true
  def handle_event("decr", _params, socket) do
    temperature = socket.assigns.thermostat.temperature - 1
    update_thermostat(socket, temperature)
  end

  @impl true
  def handle_event("incr", _params, socket) do
    temperature = socket.assigns.thermostat.temperature + 1
    update_thermostat(socket, temperature)
  end

  def update_thermostat(socket, temperature) do
    thermostat = socket.assigns.thermostat
    {:ok, thermostat} = Measurements.update_thermostat(thermostat, %{temperature: temperature})

    Phoenix.PubSub.broadcast!(
      Mch2022.PubSub,
      "thermostat:#{thermostat.id}",
      {:updated, thermostat}
    )

    {:noreply, assign(socket, :thermostat, thermostat)}
  end

  @impl true
  def handle_info({:updated, %Measurements.Thermostat{} = thermostat}, socket) do
    {:noreply, assign(socket, :thermostat, thermostat)}
  end

  defp page_title(:show), do: "Show Thermostat"
  defp page_title(:edit), do: "Edit Thermostat"
end
