class SessionsController < ApplicationController
  def new

  end

  def create
    #debugger
    user = User.from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    flash[:notice] = "Welcome #{user.nickname}"
    redirect_to posts_path
  end
end
