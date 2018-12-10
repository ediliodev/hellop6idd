class CreateMenuposrventadiaactualts < ActiveRecord::Migration[5.0]
  def change
    create_table :menuposrventadiaactualts do |t|
      t.string :sucursal
      t.date :fecha
      t.string :venta

      t.timestamps
    end
  end
end
