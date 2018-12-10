class AddGrupoprocesadoToTicketsganadorest < ActiveRecord::Migration[5.0]
  def change
    add_column :ticketsganadorests, :grupoprocesado, :string
  end
end
