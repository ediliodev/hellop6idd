class CreatePaists < ActiveRecord::Migration[5.0]
  def change
    create_table :paists do |t|
      t.string :nombre
      t.references :continentet, foreign_key: true

      t.timestamps
    end
  end
end
