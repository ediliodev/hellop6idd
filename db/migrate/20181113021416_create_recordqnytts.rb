class CreateRecordqnytts < ActiveRecord::Migration[5.0]
  def change
    create_table :recordqnytts do |t|
      t.references :ticket, foreign_key: true
      t.integer :n1
      t.integer :monto

      t.timestamps
    end
  end
end
