class CreateRecordspnnts < ActiveRecord::Migration[5.0]
  def change
    create_table :recordspnnts do |t|
      t.references :ticket, foreign_key: true
      t.integer :n1
      t.integer :n2
      t.string :siglas
      t.integer :monto

      t.timestamps
    end
  end
end
