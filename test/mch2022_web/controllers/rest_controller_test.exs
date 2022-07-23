defmodule Mch2022Web.RestControllerTest do
  use Mch2022Web.ConnCase
  alias Mch2022.Measurements
  import Mch2022.MeasurementsFixtures

  test "GET /api/thermostat/:id/:call", %{conn: conn} do
    thermostat = thermostat_fixture()
    assert thermostat.temperature == 42

    # incr
    conn = get(conn, "/api/thermostat/#{thermostat.id}/incr")
    assert conn.status == 200

    thermostat = Measurements.get_thermostat!(thermostat.id)
    assert thermostat.temperature == 43

    # decr
    conn = get(conn, "/api/thermostat/#{thermostat.id}/decr")
    assert conn.status == 200

    thermostat = Measurements.get_thermostat!(thermostat.id)
    assert thermostat.temperature == 42
  end
end
