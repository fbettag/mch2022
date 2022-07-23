defmodule Mch2022.MeasurementsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mch2022.Measurements` context.
  """

  @doc """
  Generate a thermostat.
  """
  def thermostat_fixture(attrs \\ %{}) do
    {:ok, thermostat} =
      attrs
      |> Enum.into(%{
        name: "some name",
        temperature: 42
      })
      |> Mch2022.Measurements.create_thermostat()

    thermostat
  end
end
