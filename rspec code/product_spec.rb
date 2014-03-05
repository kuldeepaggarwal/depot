require 'spec_helper'

describe Product do
  
  before do
    @product = Product.create(:title => "The Rspec Book", :description => "Learning ruby rspecs the fun way!!!", :image_url => "http://depot.com/images/test_image.jpg", :price => 45.25)
  end
  
  describe "Scopes" do
    before do
      @product2 = Product.create(:title => "A Rspec Guide", :description => "Learning ruby rspecs the fun way!!!", :image_url => "http://depot.com/images/test_image.jpg", :price => 46.75)
      @product3 = Product.create(:title => "A to Z about Rspec", :description => "Learning ruby rspecs the fun way!!!", :image_url => "http://depot.com/images/test_image.jpg", :price => 46.75)
    end
    
    it "should sort products by title always" do
      Product.all.should == [@product, @product2, @product3].sort{|a,b| a.title <=> b.title}
    end
  end
  
  describe "Relationships" do
    it { should have_many(:line_items) }
    it { should have_many(:orders) }
  end
  
  describe "Validations" do
    before do
      @product.should be_valid
    end
    
    it "should have a title" do
      @product.title = nil
      @product.should_not be_valid
      @product.errors[:title].should == ["can't be blank"]
    end
    
    it { should validate_presence_of :price }
    it { should validate_presence_of :description }
    
    it "should have a unique title" do
      @product2 = Product.new(:title => "The Rspec Book", :description => "description", :image_url => "http://depot.com/images/test_image2.jpg", :price => 45.50)
      @product2.should_not be_valid
      @product2.errors[:title].should == ["has already been taken"]
    end
    
    it "should have price greater than 0.01" do
      @product.price = 0
      @product.should_not be_valid
      @product.errors[:price].should == ["must be greater than or equal to 0.01"]
    end
    
    it "should have a valid image url" do
      @product.image_url = "http://www.google.com"
      @product.should_not be_valid
      @product.errors[:image_url].should == ["must be a URL for GIF, JPG or PNG image."]
    end
  end
  
  describe "Callbacks" do
    
    describe "Before Destroy" do
      
      context "when line-items empty" do
        it "should destroy product" do
          @product.destroy
          @product.destroyed?.should be_true
        end
      end
      
      context "when line-items not empty" do
        before do
          @cart = Cart.create
          @product.line_items << LineItem.create(:cart => @cart, :quantity => 3)
        end
        it "should not destroy product" do
          @product.destroy
          @product.destroyed?.should be_false
          @product.errors[:base].should == ['Line Items present']
        end
        
      end
    end
    
  end

end