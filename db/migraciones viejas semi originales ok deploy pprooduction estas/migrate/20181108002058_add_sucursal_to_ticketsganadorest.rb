class AddSucursalToTicketsganadorest < ActiveRecord::Migration[5.0]
  def change
    add_column :ticketsganadorests, :sucursal, :string
  end
end
