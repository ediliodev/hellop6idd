class RemoveApellidosFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :apellidos, :string
  end
end
