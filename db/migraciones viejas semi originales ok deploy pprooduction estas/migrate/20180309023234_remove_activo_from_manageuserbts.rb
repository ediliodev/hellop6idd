class RemoveActivoFromManageuserbts < ActiveRecord::Migration[5.0]
  def change
    remove_column :manageuserbts, :activo?, :boolean
  end
end
