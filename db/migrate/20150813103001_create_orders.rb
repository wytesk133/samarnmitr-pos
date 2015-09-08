class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :cart
      t.references :user, index: true, foreign_key: true
      t.text :customer #json
      t.integer :total #don't have to re-calculate from cart everytime
      t.boolean :paid, null: false

      t.timestamps null: false
    end
  end
end
