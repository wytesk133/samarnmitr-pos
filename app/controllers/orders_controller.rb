class OrdersController < ApplicationController
  before_action :authenticate

  def index
    @orders = Order.all.order('id DESC')
  end
end
