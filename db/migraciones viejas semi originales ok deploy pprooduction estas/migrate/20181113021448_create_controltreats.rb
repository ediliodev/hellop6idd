class CreateControltreats < ActiveRecord::Migration[5.0]
  def change
    create_table :controltreats do |t|
      t.integer :n1
      t.integer :n2
      t.integer :n3
      t.string :siglas
      t.integer :limite
      t.integer :vendida

      t.timestamps
    end
  end
end
