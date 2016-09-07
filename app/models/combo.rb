class Combo < ActiveRecord::Base
  validates_presence_of :name, :products, :price
  scope :available, -> { where(hidden: false) }

  def cost(selected)
    items = JSON.parse(self.products)
    idx = 0
    sum = 0
    items.each do |item|
      if item.kind_of?(Array)
        sum += Product.find(item[selected[idx]]).cost
        idx += 1
      else
        sum += Product.find(item).cost
      end
    end
    sum
  end
end
