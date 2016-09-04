class PosController < ApplicationController
  before_action :authenticate
  before_action :set_order, only: [:edit, :view, :pay, :ship]

  def index
    @order = Order.new
  end

  def edit
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
    redirect_to view_path(order)
  end

  def products
    @products = Product.available
  end

  def combos
    @combos = Combo.available
  end

  def view
    # TODO: in-place parsing
    @cart = JSON.parse(@order.cart, object_class: OpenStruct)
    @customer = JSON.parse(@order.customer, object_class: OpenStruct)
  end

  def pay
    if !@order.paid_at
      @order.paid_at = Time.now
      @order.save!
      # push data to stock stations
      # TODO: migrate to rails 5 and use actioncable
      uri = URI.parse('http://localhost:3000/publish')
      result = {}
      @order.bought.each do |key, value|
        result[key] = { name: Product.find(key).name, quantity: value }
      end
      params = { :counter => current_user.name, :items => result.to_json }
      uri.query = URI.encode_www_form(params)
      Net::HTTP.get(uri)
    end
    redirect_to view_path(@order)
  end

  def ship
    params[:ship].each do |key, value|
      key = Integer(key)
      value = Integer(value)
      if value > 0 and value <= @order.pending[key]
        @order.stocks.create!(product_id: key, delta: -value)
      end
    end
    redirect_to view_path(@order)
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end
end
