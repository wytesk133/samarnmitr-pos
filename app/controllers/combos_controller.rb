class CombosController < ApplicationController
  before_action :authenticate_admin, :admin_sidebar
  before_action :set_combo, only: [:show, :edit, :update, :destroy]

  # GET /combos
  def index
    @combos = Combo.all
  end

  # GET /combos/1
  def show
  end

  # GET /combos/new
  def new
    @combo = Combo.new
  end

  # GET /combos/1/edit
  def edit
  end

  # POST /combos
  def create
    @combo = Combo.new(combo_params)

    if @combo.save
      redirect_to @combo, notice: 'Combo was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /combos/1
  def update
    if @combo.update(combo_params)
      redirect_to @combo, notice: 'Combo was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /combos/1
  def destroy
    @combo.destroy
    redirect_to combos_url, notice: 'Combo was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_combo
      @combo = Combo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def combo_params
      params.require(:combo).permit(:name, :description, :products, :price, :picture, :hidden)
    end
end
