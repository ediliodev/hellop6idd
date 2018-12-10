class AddModificadoporToManageuserbts < ActiveRecord::Migration[5.0]
  def change
    add_column :manageuserbts, :modificadopor, :string
  end
end
