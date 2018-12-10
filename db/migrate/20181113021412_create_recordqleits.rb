class CreateRecordqleits < ActiveRecord::Migration[5.0]
  def change
    create_table :recordqleits do |t|
      t.references :ticket, foreign_key: true
      t.integer :n1
      t.integer :monto

      t.timestamps
    end
  end
end
