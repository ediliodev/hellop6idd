class CreateSupervisorts < ActiveRecord::Migration[5.0]
  def change
    create_table :supervisorts do |t|
      t.string :nombre
      t.string :apellido
      t.string :cedula
      t.string :telefono

      t.timestamps
    end
  end
end
