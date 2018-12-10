class RemoveNombreFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :nombre, :string
  end
end
