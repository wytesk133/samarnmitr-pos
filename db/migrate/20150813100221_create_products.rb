class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :cost
      t.integer :price
      t.binary :picture
      t.boolean :hidden, null: false

      t.timestamps null: false
    end
  end
end
