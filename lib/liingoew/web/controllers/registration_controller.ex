defmodule Liingoew.Web.RegistrationController do
  use Liingoew.Web, :controller

  alias Liingoew.User

  plug :scrub_params, "registration" when action in [:create, :update]

  def new(conn, _params) do
    changeset = User.registration_changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"registration" => registration_params}) do
    case Liingoew.Command.User.register_user(Liingoew.Repo, registration_params) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "User registered successfully.")
        |> redirect(to: home_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
