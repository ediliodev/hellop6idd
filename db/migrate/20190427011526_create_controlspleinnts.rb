class CreateControlspleinnts < ActiveRecord::Migration[5.0]
  def change
    create_table :controlspleinnts do |t|
      t.integer :n1
      t.integer :n2
      t.string :siglas
      t.integer :limite
      t.integer :vendida

      t.timestamps
    end
  end
end
