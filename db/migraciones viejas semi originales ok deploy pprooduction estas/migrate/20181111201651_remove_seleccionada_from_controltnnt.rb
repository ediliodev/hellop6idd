class RemoveSeleccionadaFromControltnnt < ActiveRecord::Migration[5.0]
  def change
    remove_column :controltnnts, :seleccionada, :string
  end
end
