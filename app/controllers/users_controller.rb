class UsersController < ApplicationController
  before_action :logged_in_admin, except: [:new, :create, :edit, :update, :posts_show]
  before_action :logged_in, except: [:new, :create]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def posts_show
    @posts = current_user.posts
  end

  def create
    @user = User.new(user_params_for_create)

    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    if logged_for_edit_and_update(params[:id])
      @user = User.find(params[:id])
      render 'edit'
    else
      redirect_to root_path
    end
  end

  def update
    if logged_for_edit_and_update(params[:id])
      @user = User.find(params[:id])

      if @user.update(user_params)
        redirect_to @user
      else
        render 'edit'
      end
    else
      redirect_to root_path
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

  def logged_in
    unless logged_in?
      redirect_to root_path
    end
  end

  def logged_for_edit_and_update(id)
     logged_in? && ((current_user.id.to_s == id) || is_admin?)
  end

  private
  def user_params
    # params[:user][:id] = current_user.id
    params.require(:user).permit(:name, :email, :admin, :phone, :password)
  end
  def user_params_for_create
    params[:user][:admin] = false
    params.require(:user).permit(:name, :email, :admin, :phone, :password)
  end
end
