class AddSucursalToMenuadmrresultadoglobalxsupervisort < ActiveRecord::Migration[5.0]
  def change
    add_column :menuadmrresultadoglobalxsupervisorts, :sucursal, :string
  end
end
