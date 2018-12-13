class CreateMenuf10ts < ActiveRecord::Migration[5.0]
  def change
    create_table :menuf10ts do |t|
      t.date :fecha
      t.references :sorteot, foreign_key: true

      t.timestamps
    end
  end
end
