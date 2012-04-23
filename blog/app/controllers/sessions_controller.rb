class SessionsController < ApplicationController
  def new
    flash[:failure_provider] = request.params[:provider]
    flash[:failure_type] = request.params[:message]
  end

  def create
    user = User.from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    flash[:notice] = "Welcome #{user.nickname}"
    redirect_to posts_path
  end
end
