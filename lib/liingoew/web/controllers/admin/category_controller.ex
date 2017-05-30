defmodule Liingoew.Web.Admin.CategoryController do
  use Liingoew.Web, :admin_controller

  alias Liingoew.Category

  plug :scrub_params, "category" when action in [:create, :update]

  def index(conn, _params) do
    categories = Liingoew.Query.Category.all(Repo)
    render(conn, "index.html", categories: categories)
  end

  def new(conn, _params) do
    changeset = Category.changeset(%Category{})
    categories = Liingoew.Query.Category.names_and_id(Repo)
    render(conn, "new.html", changeset: changeset, categories: categories)
  end

  def create(conn, %{"category" => category_params}) do
    case Liingoew.Command.Category.insert(Repo, category_params) do
      {:ok, _category} ->
        conn
        |> put_flash(:info, "Category created successfully.")
        |> redirect(to: admin_category_path(conn, :index))
      {:error, changeset} ->
        categories = Liingoew.Query.Category.names_and_id(Repo)
        render(conn, "new.html", changeset: changeset, categories: categories)
    end
  end

  def show(conn, %{"id" => id}) do
    category =
      Liingoew.Query.Category.get!(Repo, id)
      |> Repo.preload([:parent])

    render(conn, "show.html", category: category)
  end

  def edit(conn, %{"id" => id}) do
    category = Liingoew.Query.Category.get!(Repo, id)
    categories = Liingoew.Query.Category.names_and_id_excluding_id(Repo, id)
    changeset = Category.changeset(category)
    render(conn, "edit.html", category: category, changeset: changeset, categories: categories)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Liingoew.Query.Category.get!(Repo, id)
    case Liingoew.Command.Category.update(Repo, category, category_params) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Category updated successfully.")
        |> redirect(to: admin_category_path(conn, :show, category))
      {:error, changeset} ->
        categories = Liingoew.Query.Category.names_and_id_excluding_id(Repo, id)
        render(conn, "edit.html", category: category, changeset: changeset, categories: categories)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Liingoew.Query.Category.get!(Repo, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Liingoew.Command.Category.delete!(Repo, category)

    conn
    |> put_flash(:info, "Category deleted successfully.")
    |> redirect(to: admin_category_path(conn, :index))
  end
end
