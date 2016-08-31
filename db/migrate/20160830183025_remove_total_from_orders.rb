class RemoveTotalFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :total
  end

  def down
    add_column :orders, :total, :integer
    say_with_time 'Reverting `total` column values' do
      count = 0
      Order.find_each do |order|
        cart = JSON.parse(order.cart, object_class: OpenStruct)
        sum = 0
        cart.items.each do |item|
          sum += Product.find(item.id).price * item.quantity
        end
        cart.combos.each do |item|
          sum += Combo.find(item.id).price
        end
        order.update(total: sum)
        order.save!
        count += 1
      end
      count
    end
  end
end
