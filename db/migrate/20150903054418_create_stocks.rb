class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :product, index: true, foreign_key: true
      t.integer :delta
      t.references :order, index: true, foreign_key: true
      t.string :remark

      t.timestamps null: false
    end
  end
end
