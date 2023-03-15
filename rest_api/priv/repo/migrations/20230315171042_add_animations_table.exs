defmodule MyApp.Repo.Migrations.AddAnimationsTable do
  use Ecto.Migration

  def change do
    create table(:animations) do
      add :name, :string
      add :year_of_release, :integer

      timestamps()
  end
end
end
