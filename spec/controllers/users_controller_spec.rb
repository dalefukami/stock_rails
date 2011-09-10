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
    end
  end
end
