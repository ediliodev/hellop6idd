class CreateMenuadmrresultadoglobalts < ActiveRecord::Migration[5.0]
  def change
    create_table :menuadmrresultadoglobalts do |t|
      t.date :desde
      t.date :hasta
      t.string :sucursal
      t.integer :venta
      t.integer :ganadores
      t.integer :balance

      t.timestamps
    end
  end
end
