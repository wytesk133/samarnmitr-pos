class ProductsController < ApplicationController
  before_action :authenticate_admin, :admin_sidebar, except: :img
  before_action :set_product, only: [:show, :edit, :update, :destroy, :img]

  # GET /products
  def index
    @products = Product.all
  end

  # GET /products/1
  def show
  end

  def img
    if @product.hidden
      authenticate_admin
    end
    # TODO: what if it's not a png file
    send_data @product.picture, disposition: 'inline', type: 'image/png'
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :cost, :price, :picture, :hidden)
    end
end
