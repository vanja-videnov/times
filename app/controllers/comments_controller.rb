class CommentsController < ApplicationController

  def current_user

  end

  def index
    @comments = Comment.for_post(params[:post_id])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(body: params[:body], user_id: params[:user_id], post_id: params[:post_id])
    #@comment = Comment.new(params.require(:comment).permit(:body, :post_id, :user_id))
    @comment.save
    redirect_to user_post_comment_url(id: @comment, user_id: @comment.user_id, post_id: @comment.post_id)
  end

  def new
    @comment = Comment.new
  end

  # private
  # def comment_params
  #   params.require(:comment).permit(:body, :user_id, :post_id)
  # end
end
