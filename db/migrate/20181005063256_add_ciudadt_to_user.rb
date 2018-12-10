class AddCiudadtToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :ciudadt, foreign_key: true
  end
end
