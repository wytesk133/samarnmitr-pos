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
    end
    order.user = current_user
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
    # TODO: use json type for activerecord
    # TODO: in-place parsing
    @cart = JSON.parse(@order.cart, object_class: OpenStruct)
    @customer = JSON.parse(@order.customer, object_class: OpenStruct)
  end

  def pay
    order = Order.find(params[:id])
    if !order.paid_at
      order.paid_at = Time.now
      order.save!
      # push data to stock stations
      uri = URI.parse('http://localhost:3000/publish')
      params = { :counter => current_user.name, :items => order.bought.to_json }
      uri.query = URI.encode_www_form( params )
      Net::HTTP.get(uri)
    end
    redirect_to view_path(order.id)
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
