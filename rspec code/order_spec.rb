require 'spec_helper'

describe Order do
  
  before do
    @order = Order.create(:name => "John", :address => "Foo Street", :email => "test@depot.com", :pay_type => "Cheque")
  end
  
  describe "Relationships" do
    it { should have_many(:line_items).dependent(:destroy) }
  end
  
  describe "Validations" do
    before do
      @order.should be_valid
    end
    
    it "should have a name" do
      @order.name = nil
      @order.should_not be_valid
      @order.errors[:name].should == ["can't be blank"]
    end
    
    it "should have a valid payment type" do
      @order.pay_type = "Cash"
      @order.should_not be_valid
      @order.errors[:pay_type].should == ["not a valid option"]
    end
    
  end

  describe "#add_line_items_from_cart" do
    before do
      @product = Product.create(:title => "The Rspec Book", :description => "Learning ruby rspecs the fun way!!!", :image_url => "http://depot.com/images/test_image.jpg", :price => 45.25)
      @cart = Cart.create
      @line_item = LineItem.create(:product => @product, :cart => @cart, :quantity => 3)
    end
    
    it "should assign the line items to order" do
      @order.line_items.should be_empty
      @order.add_line_items_from_cart(@cart)
      @order.line_items.should have(1).line_item
    end
    
    it "should empty the cart" do
      @cart.line_items.should have(1).line_item
      @order.add_line_items_from_cart(@cart)
      @cart.reload
      @cart.line_items.should be_empty
    end
  end
end