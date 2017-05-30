defmodule Liingoew.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Liingoew.Web, :controller
      use Liingoew.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]
      use Liingoew.Extender
    end
  end

  def controller do
    quote do
      use Phoenix.Controller, namespace: Liingoew.Web

      alias Liingoew.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]

      import Liingoew.Web.Router.Helpers
      import Liingoew.Web.Gettext
    end
  end

  def admin_controller do
    quote do
      use Phoenix.Controller, namespace: Liingoew.Web.Admin

      alias Liingoew.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]

      import Liingoew.Web.Router.Helpers
      import Liingoew.Web.Gettext
    end
  end


  def view do
    quote do
      use Liingoew.Extender # ensure it is first import, since Phoenix.View will create some methods due to which it will not be matchable
      use Phoenix.View, root: "lib/liingoew/web/templates",
                        namespace: Liingoew.Web

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Liingoew.Web.Router.Helpers
      import Liingoew.Web.ErrorHelpers
      import Liingoew.Web.Gettext
      import Liingoew.Web.Auth.ViewHelper
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Liingoew.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]
      import Liingoew.Web.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
