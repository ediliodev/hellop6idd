class AddActivoToManageuserbts < ActiveRecord::Migration[5.0]
  def change
    add_column :manageuserbts, :activo, :boolean
  end
end
