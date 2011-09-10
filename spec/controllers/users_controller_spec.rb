require 'spec_helper'

describe UsersController do
  describe "New" do
    it "should assign user" do
      get "new"
      assigns[:user].should be_a(User)
    end
  end

  describe "Create" do
    it "should create user" do
      expect {
        post "create", {:user => FactoryGirl.attributes_for(:user)}
      }.to change(User, :count).by(1)

      response.should be_redirect
    end

    it "should not create user when email not passed" do
      attrs = FactoryGirl.attributes_for(:user)
      expect {
        post "create", {:user => attrs.merge({:email => nil})}
      }.to change(User, :count).by(0)
      response.should render_template(:new)
    end
  end
end
