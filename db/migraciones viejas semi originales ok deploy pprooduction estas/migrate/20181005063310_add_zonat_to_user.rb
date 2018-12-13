class AddZonatToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :zonat, foreign_key: true
  end
end
