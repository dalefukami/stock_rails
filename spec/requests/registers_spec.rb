require 'spec_helper'

describe "Registers" do
  describe "GET /register" do
    it "should sign up" do
      visit register_path

      fill_in "email", :with => "test.email@email.com"
      fill_in "password", :with => "somepass"
      click_button "submit"

      page.should have_content "You have registered successfully! Our app kicks ass!"

      User.find_by_email("test.email@email.com").should_not be_nil

      current_path.should eq "/"
    end
  end
end
