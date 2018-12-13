class AddFechasorteoToTicketsganadorest < ActiveRecord::Migration[5.0]
  def change
    add_column :ticketsganadorests, :fechasorteo, :date
  end
end
