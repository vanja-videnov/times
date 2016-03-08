require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  before do
    @post = FactoryGirl.create(:post)
    @user = FactoryGirl.create(:sanja)
    @comment = FactoryGirl.create(:comment)
  end
  # describe 'GET #index' do
  #
  #   it 'renders the index view' do
  #     get :index, post_id: @post, user_id: @user
  #     expect(response). to render_template :index
  #   end
  #
  #   it 'shows comments for post' do
  #     get :index, post_id: @post, user_id: @user
  #     expect(assigns(:comments)).to eq(@post.comments)
  #   end
  # end

  describe 'GET #show' do

    it 'renders the show view' do
      get :show, id: @comment, post_id: @post
      expect(response).to render_template :show
    end

    it 'shows requested comment' do
      get :show, id: @comment, post_id: @post
      expect(assigns(:comment)).to eq(@comment)
    end
  end

  # describe 'GET #new' do
  #
  #   it 'renders the new view' do
  #     get :new, post_id: @post, user_id: @user
  #     expect(response).to render_template :new
  #   end
  #
  #   it 'shows requested comment' do
  #
  #     get :new, post_id: @post, user_id: @user
  #     expect(assigns(:comment)).to be_instance_of Comment
  #   end
  # end

  # describe 'POST #create' do
  #
  #   it 'creates new instance of comment' do
  #     expect{
  #       post :create, body: @comment.body , user_id: @user, post_id: @post
  #     }.to change(Comment,:count).by(1)
  #   end
  #
  #   it 'shows created comment' do
  #     post :create, body: @comment.body , user_id: @user, post_id: @post
  #
  #     expect(response). to redirect_to(user_post_comment_path)
  #   end
  # end
end
