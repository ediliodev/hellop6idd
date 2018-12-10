class AddProvinciatToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :provinciat, foreign_key: true
  end
end
