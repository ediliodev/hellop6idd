class AddSeleccionadaToControltnnt < ActiveRecord::Migration[5.0]
  def change
    add_column :controltnnts, :seleccionada, :string
  end
end
