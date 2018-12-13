class AddFechaimpresionToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :fechaimpresion, :datetime
  end
end
