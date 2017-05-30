defmodule Liingoew.Command.LineItem do
  use Liingoew.Command, model: Liingoew.LineItem

  import Ecto.Query
  def set_shipment_unit(repo, line_item_ids, shipment_unit_id) do
    q =
      from line_item in Liingoew.LineItem,
        where:  line_item.id in ^line_item_ids,
        update: [set: [shipment_unit_id: ^shipment_unit_id]]
    repo.update_all(q, [])
  end
end
