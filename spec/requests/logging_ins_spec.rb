require 'spec_helper'

describe "LoggingIns" do
  describe "GET /login" do
    it "should log in" do
      visit login_path

      user = FactoryGirl.create(:user)
      fill_in "email", :with => user.email
      fill_in "password", :with => user.password
      click_button "submit"

      page.should have_content("Welcome #{user.email}")

      current_path.should eq "/"
    end

    it "should not log in with invalid password" do
      visit login_path

      user = FactoryGirl.create(:user)
      fill_in "email", :with => user.email
      fill_in "password", :with => user.password.upcase
      click_button "submit"

      page.should have_content("Could not log in")

      find_field('email').value.should eq(user.email)

      current_path.should eq "/sessions"
    end

    it "should not log in with invalid email" do
      visit login_path

      user = FactoryGirl.create(:user)
      junk_email = user.email+"junk"

      fill_in "email", :with => junk_email
      fill_in "password", :with => user.password
      click_button "submit"

      page.should have_content("Could not log in")

      find_field('email').value.should eq(junk_email)

      current_path.should eq "/sessions"
    end
  end
end
