defmodule Liingoew.Web.Admin.PaymentView do
  use Liingoew.Web, :view

  alias Liingoew.Payment

  defdelegate authorized?(payment), to: Payment
  defdelegate captured?(payment), to: Payment
  defdelegate refunded?(payment), to: Payment

end
