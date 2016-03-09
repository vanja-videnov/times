class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    #puts params[:session][:password]
    if user && user.authenticate(params[:session][:password])
      log_in user
      if user[:admin] == true
        redirect_to posts_path
      else
        redirect_to root_path
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
