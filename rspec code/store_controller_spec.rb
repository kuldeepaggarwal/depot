require 'spec_helper'

describe StoreController do
  
  before do
    @cart = mock Cart
    controller.stub!(:current_cart).and_return(@cart)
  end
  
  describe "#INDEX" do
    
    def do_index
      get :index
    end
    
    before do
      @product = mock Product
      @products = mock("ActiveRecord collection", :build => @product)
    end
    
    it "should fetch all products" do
      Product.should_receive(:all).and_return(@products)
      do_index
    end
    
    it "should assign current_cart" do
      do_index
      assigns(:cart).should == @cart
    end
    
    it "should render index page" do
      do_index
      response.should be_success
      response.should render_template("index")
    end
  end
  
end