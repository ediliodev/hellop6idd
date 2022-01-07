class CreateControldepagogts < ActiveRecord::Migration[5.0]
  def change
    create_table :controldepagogts do |t|
      t.string :tipojugada
      t.string :limitexticket
      t.string :limiteglobal

      t.timestamps
    end
  end
end
