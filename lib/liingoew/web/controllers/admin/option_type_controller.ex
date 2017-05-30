defmodule Liingoew.Web.Admin.OptionTypeController do
  use Liingoew.Web, :admin_controller

  alias Liingoew.OptionType

  plug :scrub_params, "option_type" when action in [:create, :update]

  def index(conn, _params) do
    option_types = Liingoew.Query.OptionType.all(Repo)
    render(conn, "index.html", option_types: option_types)
  end

  def new(conn, _params) do
    changeset = OptionType.changeset(%OptionType{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"option_type" => option_type_params}) do
    case Liingoew.Command.OptionType.insert(Repo, option_type_params) do
      {:ok, _option_type} ->
        conn
        |> put_flash(:info, "Option type created successfully.")
        |> redirect(to: admin_option_type_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    option_type = Liingoew.Query.OptionType.get!(Repo, id) |> Repo.preload(:option_values)
    render(conn, "show.html", option_type: option_type)
  end

  def edit(conn, %{"id" => id}) do
    option_type = Liingoew.Query.OptionType.get!(Repo, id) |> Repo.preload(:option_values)
    changeset = OptionType.changeset(option_type)
    render(conn, "edit.html", option_type: option_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "option_type" => option_type_params}) do
    option_type = Liingoew.Query.OptionType.get!(Repo, id) |> Repo.preload(:option_values)
    case Liingoew.Command.OptionType.update(Repo, option_type, option_type_params) do
      {:ok, option_type} ->
        conn
        |> put_flash(:info, "Option type updated successfully.")
        |> redirect(to: admin_option_type_path(conn, :show, option_type))
      {:error, changeset} ->
        render(conn, "edit.html", option_type: option_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    option_type = Liingoew.Query.OptionType.get!(Repo, id)
    Liingoew.Command.OptionType.delete!(Repo, option_type)

    conn
    |> put_flash(:info, "Option type deleted successfully.")
    |> redirect(to: admin_option_type_path(conn, :index))
  end
end
