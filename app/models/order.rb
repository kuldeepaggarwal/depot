puts "u can do it"
 class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :pay_type
  has_many :line_items, dependent: :destroy
  validates :name, :address, :email, presence: true
  validates :email, format: {
    with: /^[A-z]([A-z0-9]|[.\-_][A-z0-9])*@[A-z0-9]([A-z0-9]|[.][A-z0-9])+([.][A-z]{2,4})$/i ,
    message: "Enter a proper email address"
  }
  PAYMENT_TYPES = ["Check", "Credit Card", "Purchase Order"]
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
