class OrdersController < ApplicationController
  before_action :authenticate
  before_action :set_order, except: :index

  def index
    @orders = Order.all.order(id: :desc)
  end

  def view
    @cart = JSON.parse(@order.cart, object_class: OpenStruct)
    @customer = JSON.parse(@order.customer, object_class: OpenStruct)
  end

  def pay
    if !@order.paid_at
      @order.paid_at = Time.now
      @order.save!
      push
    end
    redirect_to view_order_path(@order)
  end

  def ship
    params[:ship].each do |key, value|
      key = Integer(key)
      value = Integer(value)
      if value > 0 and value <= @order.pending[key]
        @order.stocks.create!(product_id: key, delta: -value)
      end
    end
    redirect_to view_order_path(@order)
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def push
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
end
