require 'spec_helper'

describe SessionsController do
  
  before do
    @user = double(User, :id => 1)
  end
  
  describe "#CREATE" do
    
    def do_create
      post :create, :name => "admin", :password => "password"
    end
      
    it "should authenticate user" do
      User.should_receive(:authenticate).and_return(@user)
      do_create
    end
    
    context "when authorized" do
      before do
        User.stub!(:authenticate).and_return(@user)
      end
      
      it "should set session with user id" do
        do_create
        session[:user_id].should == @user.id
      end
      
      it "should redirect to admin dashboard" do
        do_create
        response.should redirect_to admin_path
      end
      
    end
    
    context "when unauthorized" do
      before do
        User.stub!(:authenticate).and_return(nil)
      end
      
      it "should redirect to login page" do
        do_create
        response.should redirect_to login_path
      end
      
      it "should give an alert message" do
        do_create
        flash[:alert].should eq "Invalid user/password combination"
      end
      
    end
  end
  
  
  describe "#DESTROY" do
    
    def do_destroy
      delete :destroy
    end
    
    it "should set clear session" do
      do_destroy
      session[:user_id].should be_nil
    end
    
    it "should redirect to store url" do
      do_destroy
      response.should redirect_to store_url
      flash[:notice].should == "Logged Out"
    end
    
  end
end