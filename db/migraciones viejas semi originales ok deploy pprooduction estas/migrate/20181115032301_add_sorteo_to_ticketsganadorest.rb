class AddSorteoToTicketsganadorest < ActiveRecord::Migration[5.0]
  def change
    add_column :ticketsganadorests, :sorteo, :string
  end
end
