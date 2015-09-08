class SessionController < ApplicationController
  layout "login"

  def login
    redirect_to root_path if logged_in?
  end

  def auth
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:login_error] = 'Incorrect username or password'
      render 'login'
    end
  end

  def logout
    session.delete(:user_id) #and maybe delete other user related session data
    #user related session data might be stored together in a single array/hash to be easily managed/deleted
    redirect_to root_path
  end
end
