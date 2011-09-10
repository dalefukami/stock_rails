require 'spec_helper'

describe SessionsController do
  describe "new" do
    it "should set assigns" do
      get "new"
      response.should be_success
    end
  end

  describe "create" do
    it "should create a session" do
      user = FactoryGirl.create(:user)
      post "create", {:email => user.email, :password => user.password}

      session[:user_id].should eq user.id
      response.should be_redirect
    end

    it "should not create a session with invalid password" do
      user = FactoryGirl.create(:user)
      post "create", {:email => user.email, :password => user.password.upcase}

      session[:user_id].should be_nil
      response.should render_template "new"
    end

    it "should not create a session with invalid email" do
      user = FactoryGirl.create(:user)
      post "create", {:email => 'jnk'+user.email, :password => user.password}

      session[:user_id].should be_nil
      response.should render_template "new"
    end
  end
end
