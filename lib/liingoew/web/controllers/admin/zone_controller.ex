defmodule Liingoew.Web.Admin.ZoneController do
  use Liingoew.Web, :admin_controller
  alias Liingoew.Zone

  plug :scrub_params, "zone" when action in [:create, :update]

  def index(conn, _params) do
    zones = Liingoew.Query.Zone.all(Repo)
    render(conn, "index.html", zones: zones)
  end

  def new(conn, _params) do
    zone = %Zone{}
    changeset = Zone.changeset(zone)
    render(conn, "new.html", changeset: changeset, zone: zone)
  end

  def create(conn, %{"zone" => zone_params}) do
    case Liingoew.Command.Zone.insert(Repo, zone_params) do
      {:ok, _zone} ->
        conn
        |> put_flash(:info, "Zone created successfully.")
        |> redirect(to: admin_zone_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    zone = Liingoew.Query.Zone.get!(Repo, id)
    zone_members = Liingoew.Query.Zone.member_ids_and_names(Repo, zone)
    zoneables = Liingoew.Query.Zone.zoneable_candidates(Repo, zone)
    render(conn, "show.html", zone: zone, zone_members: zone_members, zoneables: zoneables)
  end

  def edit(conn, %{"id" => id}) do
    zone = Liingoew.Query.Zone.get!(Repo, id)
    changeset = Zone.changeset(zone)
    render(conn, "edit.html", zone: zone, changeset: changeset)
  end

  def update(conn, %{"id" => id, "zone" => zone_params}) do
    zone = Liingoew.Query.Zone.get!(Repo, id)
    case Liingoew.Command.Zone.update(Repo, zone, zone_params) do
      {:ok, zone} ->
        conn
        |> put_flash(:info, "Zone updated successfully.")
        |> redirect(to: admin_zone_path(conn, :show, zone))
      {:error, changeset} ->
        render(conn, "edit.html", zone: zone, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    zone = Liingoew.Query.Zone.get!(Repo, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Liingoew.Command.Zone.delete!(Repo, zone)

    conn
    |> put_flash(:info, "Zone deleted successfully.")
    |> redirect(to: admin_zone_path(conn, :index))
  end


end
