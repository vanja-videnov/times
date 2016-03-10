class UsersController < ApplicationController
  before_action :logged_in_admin
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to action: :index
  end

  # Before filters

  # Confirms a logged-in user.
  def logged_in_admin
    unless logged_in? && is_admin?
      flash[:danger] = 'You must be admin for that privilege'
      redirect_to root_path
    end
  end

  private
  def user_params
    # params[:user][:id] = current_user.id
    params.require(:user).permit(:name, :email, :admin, :phone)
  end
end
