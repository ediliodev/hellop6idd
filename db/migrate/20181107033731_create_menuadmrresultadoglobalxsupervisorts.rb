class CreateMenuadmrresultadoglobalxsupervisorts < ActiveRecord::Migration[5.0]
  def change
    create_table :menuadmrresultadoglobalxsupervisorts do |t|
      t.date :desde
      t.date :hasta
      t.string :supervisor
      t.integer :venta
      t.integer :ganadores
      t.integer :balance

      t.timestamps
    end
  end
end
