class UseTimestampForPaymentState < ActiveRecord::Migration
  def up
    add_column :orders, :paid_at, :timestamp
    say_with_time 'Converting `paid` to `paid_at`' do
      count = 0
      Order.find_each do |order|
        if order.paid
          order.paid_at = order.updated_at # just assume
          order.save!
          count += 1
        end
      end
      count
    end
    remove_column :orders, :paid
  end

  def down
    add_column :orders, :paid, :bool
    say_with_time 'Reverting `paid` column values' do
      count = 0
      Order.find_each do |order|
        if order.paid_at
          order.paid = true
          order.save!
          count += 1
        end
      end
      count
    end
    remove_column :orders, :paid_at
  end
end
