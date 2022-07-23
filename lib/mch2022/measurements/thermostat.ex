defmodule Mch2022.Measurements.Thermostat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "thermostats" do
    field :name, :string
    field :temperature, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(thermostat, attrs) do
    thermostat
    |> cast(attrs, [:name, :temperature])
    |> validate_required([:name])
  end
end
