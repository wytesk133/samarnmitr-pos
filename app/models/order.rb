class Order < ActiveRecord::Base
  belongs_to :user
  scope :paid, -> { where.not(paid_at: nil) }
  has_many :stocks, dependent: :destroy

  # TODO: use json or serialize :cart, OpenStruct (and customer info)

  # TODO: what will happen if a product is deleted or price is changed?

  # TODO: cache `bought` and `received`

  def bought
    cart = JSON.parse(self.cart, object_class: OpenStruct)
    count = Hash.new(0)
    cart.items.each do |item|
        count[item.id] += item.quantity
    end
    cart.combos.each do |item|
        combo = Combo.find(item.id)
        products = JSON.parse(combo.products)
        pointer = 0
        products.each do |i|
          if i.kind_of?(Array)
            count[i[item.selected[pointer]]] += 1
            pointer += 1
          else
            count[i] += 1
          end
        end
    end
    count
  end

  def cost
    cart = JSON.parse(self.cart, object_class: OpenStruct)
    sum = 0
    cart.items.each do |item|
      sum += Product.find(item.id).cost * item.quantity
    end
    cart.combos.each do |item|
      sum += Combo.find(item.id).cost(item.selected)
    end
    sum
  end

  def total
    cart = JSON.parse(self.cart, object_class: OpenStruct)
    sum = 0
    cart.items.each do |item|
      sum += Product.find(item.id).price * item.quantity
    end
    cart.combos.each do |item|
      sum += Combo.find(item.id).price
    end
    sum
  end

  def received
    count = Hash.new(0)
    self.stocks.find_each do |stock|
      count[stock.product.id] -= stock.delta
    end
    count
  end

  def pending
    result = Hash.new(0)
    bought = self.bought
    received = self.received
    bought.each do |key, value|
      if value - received[key] > 0
        result[key] = value - received[key]
      end
    end
    result
  end

  def completed
    self.bought == self.received
  end

  # https://en.wikipedia.org/wiki/Sales_(accounting)#Other_terms
  def self.net_sales
    sum = 0
    Order.paid.find_each do |order|
      sum += order.total
    end
    sum
  end

  def self.gross_profit
    sum = 0
    Order.paid.find_each do |order|
      sum += order.total - order.cost
    end
    sum
  end
end
