class UseTimestampForPaymentState < ActiveRecord::Migration
  def up
    add_column :orders, :paid_at, :timestamp
    Order.find_each do |order|
      if order.paid
        order.paid_at = order.updated_at # just assume
        order.save!
      end
    end
    remove_column :orders, :paid
  end

  def down
    add_column :orders, :paid, :bool
    Order.find_each do |order|
      if order.paid_at
        order.paid = true
        order.save!
      end
    end
    remove_column :orders, :paid_at
  end
end
