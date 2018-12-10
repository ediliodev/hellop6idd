class AddSucursalToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :sucursalt, foreign_key: true
  end
end
