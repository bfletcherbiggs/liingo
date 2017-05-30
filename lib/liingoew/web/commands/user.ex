defmodule Liingoew.Command.User do
  use Liingoew.Command, model: Liingoew.User

  def register_user(repo, attrs) do
    Liingoew.User.registration_changeset(%Liingoew.User{}, attrs)
    |> repo.insert
  end

  def register_admin(repo, attrs) do
    Liingoew.User.admin_registration_changeset(%Liingoew.User{}, attrs)
    |> repo.insert
  end

  def login(repo, login_params) do
    Liingoew.User.login_changeset(%Liingoew.User{}, login_params)
    |> attempt_login(repo)
  end

  defp attempt_login(%{valid?: false} = changeset, _repo), do: {:error, changeset}
  defp attempt_login(%{valid?: true} = changeset, repo) do
    email = changeset.changes[:email]
    user  = Liingoew.Query.User.get_by(repo, email: email)
    if user do
      verify_password(user, changeset)
    else
      errored_changeset = Ecto.Changeset.add_error(changeset, :user, "Invalid credentials")
      {:error, errored_changeset}
    end
  end

  defp verify_password(user, changeset) do
    case Comeonin.Bcrypt.checkpw(changeset.changes[:password], user.encrypted_password) do
      true  -> {:ok, user}
      false -> {:error, Ecto.Changeset.add_error(changeset, :user, "Invalid credentials")}
    end
  end
end
