defmodule Liingoew.Command.State do
  use Liingoew.Command, model: Liingoew.State

  def insert_for_country(repo, country, params) do
    country
    |> Ecto.build_assoc(:states)
    |> Liingoew.State.changeset(params)
    |> repo.insert
  end
end
