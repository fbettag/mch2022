defmodule Mch2022.Repo.Migrations.CreateThermostats do
  use Ecto.Migration

  def change do
    create table(:thermostats) do
      add :name, :string
      add :temperature, :integer

      timestamps()
    end
  end
end
