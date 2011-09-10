class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.save
    redirect_to root_url, :notice =>  "You have registered successfully! Our app kicks ass!"
  end
end
