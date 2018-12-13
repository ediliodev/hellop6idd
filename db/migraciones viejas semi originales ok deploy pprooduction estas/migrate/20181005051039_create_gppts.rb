class CreateGppts < ActiveRecord::Migration[5.0]
  def change
    create_table :gppts do |t|
      t.string :nombre
      t.string :q1
      t.string :q2
      t.string :q3
      t.string :p12
      t.string :p13
      t.string :p23
      t.string :sp
      t.string :t123
      t.string :t13
      t.string :t23

      t.timestamps
    end
  end
end
