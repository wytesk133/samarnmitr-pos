class Order < ActiveRecord::Base
  belongs_to :user
  has_many :stocks

  def bought
    cart = JSON.parse(self.cart)
    count = Hash.new(0)
    cart['items'].each do |item|
        count[item['id']] += item['quantity']
    end
    cart['combos'].each do |item|
        combo = Combo.find(item['id'])
        products = JSON.parse(combo['products'])
        pointer = 0
        products.each do |i|
          if i.kind_of?(Array)
            count[i[item['selected'][pointer]]] += 1
            pointer += 1
          else
            count[i] += 1
          end
        end
    end
    count
  end

  def received
    count = Hash.new(0)
    self.stocks.each do |stock|
      count[stock.product.id] -= stock.delta
    end
    count
  end
end
