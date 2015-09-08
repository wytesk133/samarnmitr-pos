class Product < ActiveRecord::Base
  validates_presence_of :name, :price
  scope :available, -> { where(hidden: false) }
  has_many :stocks

  def current_stock #TODO: self????
    sum = 0
    self.stocks.each do |stock|
      sum += stock.delta
    end
    sum
  end
end
