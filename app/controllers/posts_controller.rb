class PostsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    if is_owner_or_admin(params[:id])
      @post = Post.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    if is_owner_or_admin(params[:id])
      @post = Post.find(params[:id])

      if @post.update(post_params)
        redirect_to @post
      else
        render 'edit'
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    if is_owner_or_admin(params[:id])
      @post = Post.find(params[:id])
      @post.destroy

      redirect_to action: :index
    else
      redirect_to root_path
    end
  end

  # Before filters

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "You must be logged in!"
      redirect_to root_path
    end
  end

  def is_owner_or_admin(post_id)
    is_owner?(post_id) || is_admin?
  end


  private
  def post_params
    params[:post][:user_id] = current_user.id
    params.require(:post).permit(:title, :body, :user_id)
  end
end
