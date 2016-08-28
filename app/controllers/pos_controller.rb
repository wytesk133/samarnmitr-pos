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
    #TODO: sanitize
    order.customer = params[:customer].to_json
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
    @order = Order.find(params[:id])
  end

  def view
    @order = Order.find(params[:id])
  end

  def pay
    #TODO: paid date-time
    order = Order.find(params[:id])
    order.paid = true
    order.save!
    render nothing: true #TODO: render success (json style)
  end

  def ship
    order = Order.find(params[:id])
    params[:ship].each do |key, value|
      # TODO: use before_action to comply with DRY
      value = Integer(value)
      if value != 0
        order.stocks.create!(product_id: key, delta: -value)
      end
      # TODO: catch any errors and revert changes ._.
    end
    redirect_to view_path(order.id)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.permit(:cart, :customer_name, :customer_info, :total) #TODO: remove :total and re-calculate them on server side
    end
end
