require 'rails_helper'

RSpec.describe PostsController, type: :controller do
include SessionsHelper
  before do
    @post = FactoryGirl.create(:post)
    @post2 = FactoryGirl.create(:post2)
    @posts = [@post, @post2]
    @comment = FactoryGirl.create(:comment)
  end

  describe 'GET #index' do

    it 'renders the index view' do
      get :index
      expect(response). to render_template :index
    end

    it 'shows all posts' do
      get :index
      expect(assigns(:posts)).to eq(@posts)
    end
  end

  describe 'GET #show' do

    it 'renders the show view' do
      get :show, id: @post
      expect(response).to render_template :show
    end

    it 'shows specific post' do
      get :show, id: @post
      expect(assigns(:post)).to eq(@post)
    end

    it 'assigns posts comments' do
      get :show, id: @post2.id
      expect(assigns(:post).comments).to eq(@post2.comments)
    end
  end

  describe 'GET #edit' do

    before do
      @user = create(:sanja)
      log_in(@user)
    end
    after do
      log_out
    end
    it 'renders the edit view' do
      get :edit, id: @post
      expect(response).to render_template :edit
    end

    it 'shows specific post' do
      get :edit, id: @post
      expect(assigns(:post)).to eq(@post)
    end
  end

  describe 'PATCH #update' do

    before do
      @user = create(:sanja)
      log_in(@user)
    end
    after do
      log_out
    end
    it 'update specific post' do
      patch :update, id: @post, post: attributes_for(:post, body: "This is bodybla")
      @post.reload
      expect(@post.body).to eq("This is bodybla")
    end

    it 'renders that post page' do
      patch :update, id: @post, post: attributes_for(:post, body: "This is bodybla")
      @post.reload
      expect(response).to redirect_to(action: :show)
    end
  end

  describe 'DELETE #destroy' do
    before do
      @user = create(:sanja)
      log_in(@user)
    end
    after do
      log_out
    end
    it 'delete selected post' do
      delete :destroy, id: @post
      expect(Post.exists?(@post.id)).to be_falsey
    end

    it 'expect to render index page' do
      delete :destroy, id: @post
      expect(response). to redirect_to(action: :index)
    end
  end

  describe 'GET #logged_in_user' do
    it 'render root view when is not logged in' do
      get :logged_in_user
      expect(response).to redirect_to root_path
      expect(flash[:danger]).to be_present
    end
    # context 'logged in' do
    #   before do
    #     @user = create(:sanja)
    #     log_in(@user)
    #   end
    #   after do
    #     log_out
    #   end
    #
    #   it 'works nothing when logged in' do
    #     get :logged_in_user
    #     expect(controller).not_to set_flash[:danger]
    #   end
    # end
  end
end
