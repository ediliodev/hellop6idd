class CreateControlqleits < ActiveRecord::Migration[5.0]
  def change
    create_table :controlqleits do |t|
      t.integer :numero
      t.integer :limite
      t.integer :vendida

      t.timestamps
    end
  end
end
