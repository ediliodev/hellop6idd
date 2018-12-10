class CreateProvinciats < ActiveRecord::Migration[5.0]
  def change
    create_table :provinciats do |t|
      t.string :nombre
      t.references :paist, foreign_key: true

      t.timestamps
    end
  end
end
