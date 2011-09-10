require 'spec_helper'


describe "Registers" do
  describe "GET /register" do
    def fill_form(user)
      fill_in "email", :with => user.email
      fill_in "password", :with => user.password
      fill_in "password_confirmation", :with => (user.password_confirmation || user.password)
    end

    before(:each) do 
      visit register_path
      @user = FactoryGirl.build(:user)
    end

    it "should sign up" do
      fill_form(@user)

      click_button "submit"

      page.should have_content "You have registered successfully! Our app kicks ass!"

      User.find_by_email(@user.email).should_not be_nil

      current_path.should eq "/"
    end

    it "should require email" do
      @user.email = nil
      fill_form(@user)

      expect {
        click_button "submit"
      }.to change(User, :count).by(0)

      page.should have_content "Form is invalid"
      page.should have_content "Email can't be blank"

      find_field('password').value.should be_nil
      find_field('password_confirmation').value.should be_nil

      current_path.should eq("/users")
    end

    it "should require password" do
      @user.password = nil
      fill_form(@user)

      expect {
        click_button "submit"
      }.to change(User, :count).by(0)

      page.should have_content "Form is invalid"
      page.should have_content "Password digest can't be blank"

      find_field('email').value.should eq(@user.email)

      current_path.should eq("/users")
    end

    it "should require password confirmation" do
      @user.password_confirmation = ""
      fill_form(@user)

      expect {
        click_button "submit"
      }.to change(User, :count).by(0)

      page.should have_content "Form is invalid"
      page.should have_content "Password doesn't match confirmation"

      find_field('email').value.should eq(@user.email)

      current_path.should eq("/users")
    end
  end
end
