defmodule Mch2022Web.RestController do
  use Mch2022Web, :controller
  alias Mch2022.Measurements

  def thermostat(conn, %{"id" => id, "call" => "incr"}) do
    thermostat = Measurements.get_thermostat!(id)
    temperature = thermostat.temperature + 1
    update_thermostat(thermostat, temperature)
    send_resp(conn, 200, "")
  end

  def thermostat(conn, %{"id" => id, "call" => "decr"}) do
    thermostat = Measurements.get_thermostat!(id)
    temperature = thermostat.temperature - 1
    update_thermostat(thermostat, temperature)
    send_resp(conn, 200, "")
  end

  def update_thermostat(thermostat, temperature) do
    {:ok, thermostat} = Measurements.update_thermostat(thermostat, %{temperature: temperature})

    Phoenix.PubSub.broadcast!(
      Mch2022.PubSub,
      "thermostat:#{thermostat.id}",
      {:updated, thermostat}
    )
  end
end
