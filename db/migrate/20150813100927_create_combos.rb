class CreateCombos < ActiveRecord::Migration
  def change
    create_table :combos do |t|
      t.string :name
      t.string :description
      t.string :products
      t.integer :price
      t.binary :picture
      t.boolean :hidden, null: false

      t.timestamps null: false
    end
  end
end
