class Product < ActiveRecord::Base
  validates_presence_of :name, :price
  scope :available, -> { where.not(hidden: true) }
  has_many :stocks

  def current_stock
    sum = 0
    self.stocks.find_each do |stock|
      sum += stock.delta
    end
    sum
  end
end
