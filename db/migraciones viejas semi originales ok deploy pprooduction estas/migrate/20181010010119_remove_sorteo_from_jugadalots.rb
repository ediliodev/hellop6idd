class RemoveSorteoFromJugadalots < ActiveRecord::Migration[5.0]
  def change
    remove_column :jugadalots, :sorteo, :string
  end
end
