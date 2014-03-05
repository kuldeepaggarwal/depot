require_relative '../spec_helper'

describe ProductsController, :type => :controller do

  def post_create_request
    post :create, { :product => {:title => 'test' }}
  end

  describe '#CREATE' do
    before do
      @product = mock_model(Product, id: 1, :save => false)
    end

    it "should call Product's new" do
      Product.should_receive(:new).with({ 'title' => 'test' }).and_return(@product)
      post_create_request
    end

    it 'product should call save' do
      Product.stub(:new).and_return(@product)
      @product.should_receive(:save)
      post_create_request
    end

    context 'when saved' do
      before do
        Product.stub(:new).and_return(@product)
        @product.stub(:save).and_return(true)
        post_create_request
      end

      it 'should redirect to show' do
        response.should redirect_to @product
      end

      it 'should have response code 302' do
        response.code.should eq('302')
      end

      it 'should set flash notice' do
        flash[:notice].should eq('Product was successfully created.')
      end
    end

    context 'when unsaved' do
      before do
        Product.stub(:new).and_return(@product)
        post_create_request
      end

      it 'should render new' do
        response.should render_template :new
      end

      it 'should have response code 200' do
        response.code.should eq('200')
      end

    end
  end
end