class CreateEmpleadots < ActiveRecord::Migration[5.0]
  def change
    create_table :empleadots do |t|
      t.string :nombre
      t.string :apellido
      t.string :cedula
      t.string :telefono

      t.timestamps
    end

    
   create_table :sucursalts do |t|
      t.string :nombre
      t.string :descripcion

      t.timestamps
    end


  end
end


