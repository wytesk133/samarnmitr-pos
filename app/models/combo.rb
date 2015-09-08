class Combo < ActiveRecord::Base
  validates_presence_of :name, :products, :price
  scope :available, -> { where(hidden: false) }
end
