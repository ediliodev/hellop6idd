class AddComandojugadaToJugadalot < ActiveRecord::Migration[5.0]
  def change
    add_column :jugadalots, :comandojugada, :string
  end
end
