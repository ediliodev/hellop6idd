class CreateMenuts < ActiveRecord::Migration[5.0]
  def change
    create_table :menuts do |t|

      t.timestamps
    end
  end
end
