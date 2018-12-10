class CreateMenuposrventaxfechats < ActiveRecord::Migration[5.0]
  def change
    create_table :menuposrventaxfechats do |t|
      t.string :sucursal
      t.date :desde
      t.date :hasta
      t.string :venta

      t.timestamps
    end
  end
end
