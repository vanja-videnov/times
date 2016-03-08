require 'rails_helper'

RSpec.describe PostsController, type: :controller do

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
      expect(response). to render_template :show
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
end
