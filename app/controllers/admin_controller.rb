class AdminController < ApplicationController
  before_action :authenticate_admin, :admin_sidebar

  def index
    redirect_to :dashboard
  end

  def dashboard
    @net_sales = Order.net_sales
    @gross_profit = Order.gross_profit
    @products = Product.all
    @bought = Hash.new(0)
    Order.paid.find_each do |order|
      bought = order.bought
      bought.each do |key, value|
        @bought[key] += value
      end
    end
  end
end
