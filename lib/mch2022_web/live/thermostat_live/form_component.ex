defmodule Mch2022Web.ThermostatLive.FormComponent do
  use Mch2022Web, :live_component

  alias Mch2022.Measurements

  @impl true
  def update(%{thermostat: thermostat} = assigns, socket) do
    changeset = Measurements.change_thermostat(thermostat)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"thermostat" => thermostat_params}, socket) do
    changeset =
      socket.assigns.thermostat
      |> Measurements.change_thermostat(thermostat_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"thermostat" => thermostat_params}, socket) do
    save_thermostat(socket, socket.assigns.action, thermostat_params)
  end

  defp save_thermostat(socket, :edit, thermostat_params) do
    case Measurements.update_thermostat(socket.assigns.thermostat, thermostat_params) do
      {:ok, _thermostat} ->
        {:noreply,
         socket
         |> put_flash(:info, "Thermostat updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_thermostat(socket, :new, thermostat_params) do
    case Measurements.create_thermostat(thermostat_params) do
      {:ok, _thermostat} ->
        {:noreply,
         socket
         |> put_flash(:info, "Thermostat created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
