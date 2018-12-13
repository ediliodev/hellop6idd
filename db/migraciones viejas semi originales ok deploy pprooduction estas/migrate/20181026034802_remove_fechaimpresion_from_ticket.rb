class RemoveFechaimpresionFromTicket < ActiveRecord::Migration[5.0]
  def change
    remove_column :tickets, :fechaimpresion, :date
  end
end
