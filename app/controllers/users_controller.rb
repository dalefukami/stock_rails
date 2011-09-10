class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice =>  "You have registered successfully! Our app kicks ass!"
    else
      flash.now.notice = "Could not save user"
      render "new"
    end
  end
end
