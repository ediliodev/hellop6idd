class CreateSucursalts < ActiveRecord::Migration[5.0]
  def change
    create_table :sucursalts do |t|
      t.string :nombre
      t.string :descripcion
      t.references :consorciot, foreign_key: true

      t.timestamps
    end
  end
end


#20181210063549_create_sucursalts
#20171124004028_create_empleadots