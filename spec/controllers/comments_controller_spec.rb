require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  include SessionsHelper
  before do
    @post = FactoryGirl.create(:post)
    @user = FactoryGirl.create(:sanja)
    @user2 = FactoryGirl.create(:not_admin)
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

  describe 'GET #new' do

    context 'when is not logged in' do
      it 'renders the root view' do
        get :new, post_id: @post
        expect(response).to redirect_to root_path
      end
    end

    context 'when is logged in' do
      before do
        log_in(@user)
      end
      after do
        log_out
      end
      it 'shows new comment form' do
        get :new, post_id: @post
        expect(response).to render_template :new
      end

      it 'expect form for comment' do
        get :new, post_id: @post
        expect(assigns(:comment)).to be_instance_of Comment
      end
    end

  end

  describe 'POST #create' do

    context 'when is not logged in' do
      it 'dont creates new instance of comment' do
        expect{
          post :create, body: @comment.body, post_id: @post
        }.not_to change(Comment,:count)
      end
    end

    context 'when is logged in' do
      before do
        log_in(@user)
        @count = Comment.count
        @count+=1
      end
      after do
        log_out
      end

      it 'creates new instance of comment' do
        post :create, post_id: @post, comment: attributes_for(:comment, body: @comment.body)
        expect(Comment.count).to eq(@count)
      end

      it 'show post that is commented' do
        post :create, post_id: @post, comment: attributes_for(:comment, body: @comment.body)
        expect(response).to redirect_to post_path(id: @post.id)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when is logged in as admin' do
      before do
        log_in(@user)
      end
      after do
        log_out
      end
      it 'destroy commment' do
        delete :destroy, post_id: @post, id: @comment
        expect(response).to redirect_to post_path(@post.id)
      end
    end

    context 'when is logged in as regular user' do
      before do
        log_in(@user2)
      end
      after do
        log_out
      end
      it 'dont destroy commment' do
        delete :destroy, post_id: @post, id: @comment
        expect(response).not_to redirect_to post_path(@post.id)
      end
      it 'dont delete comment' do
        delete :destroy, post_id: @post, id: @comment
        expect(Comment.exists?(@post.id)).to be_truthy
      end
    end

    context 'when is not logged in' do
      it 'dont delete comment' do
        delete :destroy, post_id: @post, id: @comment
        expect(response).to redirect_to root_path
      end
    end

  end

end
