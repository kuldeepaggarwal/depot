class ApplicationController < ActionController::Base
  # before_filter :authorize
  protect_from_forgery
  protected
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end

  private
  
    def current_cart
      session[:counter] = 0
      Cart.find(session[:cart_id])      
      rescue ActiveRecord::RecordNotFound
        cart = Cart.create
        session[:cart_id] = cart.id
        cart
    end
    # def inc_count
    #   session[:counter] ||= 0
    #   session[:counter] += 1
    # end
end
