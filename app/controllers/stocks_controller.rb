class StocksController < ApplicationController
  before_action :authenticate_admin, :admin_sidebar

  # GET /stocks
  def index
    @not_shipped = Hash.new(0)
    Order.paid.find_each do |order|
      order.pending.each do |key, value|
        @not_shipped[key] += value
      end
    end
    @products = Product.all
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # POST /stocks
  def create
    @stock = Stock.new(stock_params)

    if @stock.save
      redirect_to stocks_url, notice: 'Stock was successfully created.'
    else
      render :new
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def stock_params
      params.require(:stock).permit(:product_id, :delta, :remark)
    end
end
