class CreateSociots < ActiveRecord::Migration[5.0]
  def change
    create_table :sociots do |t|
      t.string :nombre
      t.string :apellido
      t.string :telefono

      t.timestamps
    end
  end
end
