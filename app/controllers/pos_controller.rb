class PosController < ApplicationController
  before_action :authenticate

  def index
    @order = Order.new
  end

  def edit
    @order = Order.find(params[:id])
    if @order.paid_at
      raise 'Cannot modify paid orders'
    end
  end

  def save
    if params.has_key?(:id)
      order = Order.find(params[:id])
      if order.paid_at
        raise 'Cannot modify paid orders'
      end
    else
      order = Order.new
      order.user = current_user
    end
    #TODO: verify params again: whether they are submitted or not
    order.cart = params[:cart]
    #TODO: sanitize
    order.customer = params[:customer].to_json
    order.save!
    redirect_to view_order_path(order)
  end

  def products
    @products = Product.available
  end

  def combos
    @combos = Combo.available
  end
end
