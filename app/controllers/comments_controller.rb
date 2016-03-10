class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  def index
    @comments = Comment.for_post(params[:post_id])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to post_path(id: @comment.post_id)
  end

  def new
    @comment = Comment.new
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

  # Before filters

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "You must be logged in!"
      redirect_to root_path
    end
  end
  private
  def comment_params
    params[:comment][:user_id] = current_user.id
    params[:comment][:post_id] = params[:post_id] || params[:id]
    params.require(:comment).permit(:body, :user_id, :post_id)
  end
end
