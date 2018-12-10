class AddApellidosToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :apellidos, :string
  end
end
