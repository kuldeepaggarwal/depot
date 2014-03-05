class AdminController < ApplicationController
  def index
    @orders = Order.paginate page: params[:page], order: 'created_at desc',
      per_page: 10
    @total_orders = Order.count
  end
end
