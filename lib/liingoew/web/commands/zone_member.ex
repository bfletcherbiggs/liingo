defmodule Liingoew.Command.ZoneMember do
  use Liingoew.Command, model: Liingoew.ZoneMember

  def insert_for_zone(repo, zoneable, %Liingoew.Zone{id: zone_id}) do
    zoneable
    |> Ecto.build_assoc(:zone_members)
    |> Liingoew.ZoneMember.changeset(%{zone_id: zone_id})
    |> repo.insert
  end

end
