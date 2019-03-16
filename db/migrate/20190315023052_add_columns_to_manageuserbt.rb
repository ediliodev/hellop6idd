class AddColumnsToManageuserbt < ActiveRecord::Migration[5.0]
  def change
    add_column :manageuserbts, :telefono, :string
    add_column :manageuserbts, :sucursal, :string
    add_column :manageuserbts, :tipousuario, :string
    add_column :manageuserbts, :consorcio, :string
    add_column :manageuserbts, :sucursalbt, :string
    add_column :manageuserbts, :siglas, :string
    add_column :manageuserbts, :direccion, :string
    add_column :manageuserbts, :ciudad, :string
    add_column :manageuserbts, :provincia, :string
    add_column :manageuserbts, :zona, :string
    add_column :manageuserbts, :vendedor, :string
    add_column :manageuserbts, :contacto, :string
    add_column :manageuserbts, :supervisor, :string
    add_column :manageuserbts, :colector, :string
    add_column :manageuserbts, :socio, :string
    add_column :manageuserbts, :gppt, :string
  end
end
