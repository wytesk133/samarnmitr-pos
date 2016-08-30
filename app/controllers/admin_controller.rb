class AdminController < ApplicationController
  before_action :authenticate_admin, :admin_sidebar

  def index
    redirect_to :dashboard
  end

  def dashboard
    @total = 0
    @bought = Hash.new(0)
    Order.paid.find_each do |order|
      @total += order.total
      bought = order.bought
      bought.each do |key, value|
        @bought[key] += value
      end
    end
    @products = Product.all
  end
end
