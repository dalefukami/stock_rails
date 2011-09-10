class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Welcome #{user.email}"
    else
      flash.now.notice = "Could not log in"
      render "new"
    end
  end
end
