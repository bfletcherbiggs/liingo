defmodule Liingoew.Shipment.Splitter do

  alias Liingoew.Shipment.Splitter.DoNotSplit

  def split(order) do
    shipment_splitter = configured_shipment_splitter() || DoNotSplit
    shipment_splitter.split(order)
  end

  defp configured_shipment_splitter do
    Application.get_env(:Liingoew, :shipment_splitter)
  end

end
