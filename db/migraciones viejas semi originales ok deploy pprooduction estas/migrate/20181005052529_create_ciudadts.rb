class CreateCiudadts < ActiveRecord::Migration[5.0]
  def change
    create_table :ciudadts do |t|
      t.string :nombre
      t.references :provinciat, foreign_key: true

      t.timestamps
    end
  end
end
