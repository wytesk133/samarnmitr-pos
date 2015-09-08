class PosController < ApplicationController
  before_action :authenticate

  def index
  end

  def edit
  end

  def save
    if params.has_key?(:id) # TODO: this is somehow insecure
      order = Order.find(params[:id]) #TODO: if not found?
    else
      order = Order.new
      order.paid = false
    end
    order.user = current_user #TODO: this is somehow "._."
    #TODO: verify params again: whether they are submitted or not
    order.cart = params[:cart]
    customer = Hash.new
    customer[:name] = params[:customer_name]
    customer[:info] = params[:customer_info]
    order.customer = customer.to_json
    #TODO: re-calculate sum
    #for now, just trust user input (although that is scary ._.)
    order.total = params[:total]
    order.save!
    redirect_to view_path(order.id)
  end

  def products
    @products = Product.available
  end

  def combos
    @combos = Combo.available
  end

  def load_cart
    @order = Order.find(params[:id]) #TODO: if not found?
  end

  def view
    @order = Order.find(params[:id]) #TODO: find vs find_by_id
    @bought = @order.bought
    @received = @order.received
  end

  def pay
    #TODO: paid date-time
    order = Order.find(params[:id])
    order.paid = true
    order.save!
    render nothing: true #TODO: render success (json style)
  end

  def ship
    # ~heavy duty, heavy query~ ._.
    order = Order.find(params[:id])
    bought = order.bought
    received = order.received
    @ship = Hash.new(0)
    # TODO: http://api.rubyonrails.org/classes/ActiveRecord/Locking.html
    bought.each do |key, value|
      @ship[key] = [Product.find(key).current_stock, value-received[key]].min
      @ship[key] = [@ship[key], 0].max # fail  safe TODO: find a better way
      if @ship[key] != 0
        stock = Stock.new
        stock.product = Product.find(key)
        stock.delta = -@ship[key]
        stock.order = order
        stock.save!
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.permit(:cart, :customer_name, :customer_info, :total) #TODO: remove :total and re-calculate them on server side
    end
end
