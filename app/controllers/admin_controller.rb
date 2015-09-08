class AdminController < ApplicationController
  before_action :authenticate_admin, :admin_sidebar

  def index
    redirect_to :dashboard
  end

  def dashboard
    @total = 0
    Order.where(paid: true).each do |order|
      @total += order.total
    end
  end
end
