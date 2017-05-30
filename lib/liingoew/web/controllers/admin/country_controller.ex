defmodule Liingoew.Web.Admin.CountryController do
  use Liingoew.Web, :admin_controller

  alias Liingoew.Country

  plug :scrub_params, "country" when action in [:create, :update]

  def index(conn, _params) do
    countries = Liingoew.Query.Country.all(Repo)
    render(conn, "index.html", countries: countries)
  end

  def new(conn, _params) do
    changeset = Country.changeset(%Country{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"country" => country_params}) do
    case Liingoew.Command.Country.insert(Repo, country_params) do
      {:ok, _country} ->
        conn
        |> put_flash(:info, "Country created successfully.")
        |> redirect(to: admin_country_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    country = Liingoew.Query.Country.get!(Repo, id) |> Repo.preload(:states)
    render(conn, "show.html", country: country)
  end

  def edit(conn, %{"id" => id}) do
    country = Liingoew.Query.Country.get!(Repo, id)
    changeset = Country.changeset(country)
    render(conn, "edit.html", country: country, changeset: changeset)
  end

  def update(conn, %{"id" => id, "country" => country_params}) do
    country = Liingoew.Query.Country.get!(Repo, id)
    case Liingoew.Command.Country.update(Repo, country, country_params) do
      {:ok, country} ->
        conn
        |> put_flash(:info, "Country updated successfully.")
        |> redirect(to: admin_country_path(conn, :show, country))
      {:error, changeset} ->
        render(conn, "edit.html", country: country, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    country = Liingoew.Query.Country.get!(Repo, id)
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Liingoew.Command.Country.delete!(Repo, country)

    conn
    |> put_flash(:info, "Country deleted successfully.")
    |> redirect(to: admin_country_path(conn, :index))
  end

end
