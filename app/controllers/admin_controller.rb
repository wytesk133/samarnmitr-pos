class AdminController < ApplicationController
  before_action :authenticate_admin, :admin_sidebar

  def index
    redirect_to :dashboard
  end

  def dashboard
    @total = 0
    @not_shipped = Hash.new(0)
    Order.where(paid: true).each do |order|
      @total += order.total
      bought = order.bought
      received = order.received
      bought.each do |key, value|
        @not_shipped[key] += value-received[key]
      end
    end
    @products = Product.all
  end
end
