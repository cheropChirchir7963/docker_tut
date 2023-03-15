defmodule MyApp.Animation do
  use Ecto.Schema

  schema "animations" do
    field :name, :string
    field :year_of_release, :integer

    timestamps()
  end
end
