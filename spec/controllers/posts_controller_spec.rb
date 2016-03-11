require 'rails_helper'

RSpec.describe PostsController, type: :controller do
include SessionsHelper
  before do
    @post = FactoryGirl.create(:post)
    @post2 = FactoryGirl.create(:post2)
    @posts = [@post, @post2]
    @comment = FactoryGirl.create(:comment)
    @user = FactoryGirl.create(:sanja)
    @user2 = FactoryGirl.create(:not_admin)
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

  describe 'GET #new' do
    before do
      log_in(@user)
    end
    after do
      log_out
    end
    it 'renders the new view' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before do
      @count = Post.count
      @count+=1
    end
    context 'when is not logged in' do
      it 'dont creates new instance of post' do
        expect{
          post :create, title: @post.title, body: @post.body, user_id: @post.user_id
        }.not_to change(Post,:count)
      end
    end

    context 'when is logged in' do
      before do
        log_in(@user)
      end
      after do
        log_out
      end

      it 'creates new instance of post' do
        post :create, post: attributes_for(:post)
        expect(Post.count).to eq(@count)
      end

      it 'show post that is created' do
        post :create, post: attributes_for(:post)
        expect(response).to redirect_to post_path(id: Post.last.id)
      end

      it 'render new page if params are not valid' do
        post :create, post: attributes_for(:post, title: "v")
        expect(response).to render_template :new
      end
    end

  end

  describe 'GET #edit' do
    before do
      log_in(@user)
    end
    after do
      log_out
    end
    context 'when is admin' do
      it 'renders the edit view' do
        get :edit, id: @post
        expect(response).to render_template :edit
      end

      it 'shows specific post' do
        get :edit, id: @post
        expect(assigns(:post)).to eq(@post)
      end
    end

    context 'when is logged user owner' do
      before do
        log_out
        log_in(@user2)
      end
      after do
        log_out
        log_in(@user)
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

    context 'when is not logged in' do
      before do
        log_out
      end
      after do
        log_in(@user)
      end
      it 'dont render the edit view' do
        get :edit, id: @post
        expect(response).not_to render_template :edit
      end

      it 'dont show specific post' do
        get :edit, id: @post
        expect(assigns(:post)).to be_falsey
      end

      it 'render the root view' do
        get :edit, id: @post
        expect(response).to redirect_to root_path
      end
    end

    context 'when is logged in but not the owner' do
      before do
        log_out
        @test_user = FactoryGirl.create(:user_3)
        log_in(@test_user)
      end
      after do
        log_out
        log_in(@user)
      end
      it 'render the root view' do
        get :edit, id: @post
        expect(response).to redirect_to root_path
      end
    end

  end

  describe 'PATCH #update' do

    before do
      log_in(@user)
    end
    after do
      log_out
    end

    context 'when is admin' do
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

    context 'when logged user is owner' do
      before do
        log_out
        log_in(@user2)
      end
      after do
        log_out
        log_in(@user)
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

    context 'when is not logged in' do
      before do
        log_out
      end
      after do
        log_in(@user2)
      end
      it 'dont update specific post' do
        patch :update, id: @post, post: attributes_for(:post, body: "This is bodybla")
        @post.reload
        expect(@post.body).not_to eq("This is bodybla")
      end

      it 'dont render that post page' do
        patch :update, id: @post, post: attributes_for(:post, body: "This is bodybla")
        @post.reload
        expect(response).not_to redirect_to(action: :show)
      end
    end

    context 'when is logged in but not the owner' do
      before do
        log_out
        @test_user = FactoryGirl.create(:user_3)
        log_in(@test_user)
      end
      after do
        log_out
        log_in(@user)
      end
      it 'render the root view' do
        patch :update, id: @post, post: attributes_for(:post, body: "This is bodybla")
        expect(response).to redirect_to root_path
      end
    end

    context 'when is owner but params are wrong' do
      before do
        log_out
        log_in(@user2)
      end
      after do
        log_out
        log_in(@user)
      end
      it 'update specific post' do
        patch :update, id: @post, post: attributes_for(:post, body: "T")
        @post.reload
        expect(@post.body).not_to eq("This is bodybla")
      end

      it 'renders edit page' do
        patch :update, id: @post, post: attributes_for(:post, body: "T")
        @post.reload
        expect(response).to render_template :edit
      end
    end

  end

  describe 'DELETE #destroy' do
    before do
      log_in(@user)
    end
    after do
      log_out
    end

    context 'when is admin' do
      it 'delete selected post' do
        delete :destroy, id: @post
        expect(Post.exists?(@post.id)).to be_falsey
      end

      it 'expect to render index page' do
        delete :destroy, id: @post
        expect(response). to redirect_to(action: :index)
      end
    end

    context 'when logged user is owner' do
      before do
        log_out
        log_in(@user2)
      end
      after do
        log_out
        log_in(@user)
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

    context 'when is not logged in' do
      before do
        log_out
      end
      after do
        log_in(@user)
      end
      it 'dont delete selected post' do
        delete :destroy, id: @post
        expect(Post.exists?(@post.id)).to be_truthy
      end

      it 'expect not to render index page' do
        delete :destroy, id: @post
        expect(response).to redirect_to root_path
      end

    end
    context 'when is logged in but not the owner' do
      before do
        log_out
        @test_user = FactoryGirl.create(:user_3)
        log_in(@test_user)
      end
      after do
        log_out
        log_in(@user)
      end
      it 'render the root view' do
        delete :destroy, id: @post
        expect(response).to redirect_to root_path
      end
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
