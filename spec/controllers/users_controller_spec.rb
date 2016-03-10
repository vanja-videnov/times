require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include SessionsHelper
  before do
    @user = FactoryGirl.create(:sanja)
    @user2 = FactoryGirl.create(:not_admin)
    @users = [@user, @user2]
    log_in(@user)
  end
  after do
    log_out
  end
  describe 'GET #index' do

    it 'renders the index view' do
      get :index
      expect(response). to render_template :index
    end

    it 'shows all users' do
      get :index
      expect(assigns(:users)).to eq(@users)
    end
  end

  describe 'GET #show' do

    it 'renders the show view' do
      get :show, id: @user
      expect(response).to render_template :show
    end

    it 'shows specific user' do
      get :show, id: @user
      expect(assigns(:user)).to eq(@user)
    end

  end

  describe 'GET #edit' do

    it 'renders the edit view' do
      get :edit, id: @user
      expect(response).to render_template :edit
    end

    it 'shows specific user' do
      get :edit, id: @user
      expect(assigns(:user)).to eq(@user)
    end
  end

  describe 'PATCH #update' do

    context 'when params are not valid' do
      it 'dont update specific user' do
        patch :update, id: @user.id, user: attributes_for(:sanja, email: "vaab")
        @user.reload
        expect(@user.email).not_to eq("vaab")
      end
      it 'render edit page' do
        patch :update, id: @user.id, user: attributes_for(:sanja, email: "vaab")
        expect(response).to render_template :edit
      end
    end
    context 'when params are valid' do
      it 'update specific user' do
        patch :update, id: @user.id, user: attributes_for(:sanja, name: "Vanja Vanjaa")
        @user.reload
        expect(@user.name).to eq("Vanja Vanjaa")
      end

      it 'renders that user page' do
        patch :update, id: @user, user: attributes_for(:sanja, name: "Vanja Vanjaa")
        @user.reload
        expect(response).to redirect_to(action: :show)
      end
    end

  end

  describe 'DELETE #destroy' do
    it 'delete selected user' do
      delete :destroy, id: @user2
      expect(User.exists?(@user2.id)).to be_falsey
    end

    it 'expect to render index page' do
      delete :destroy, id: @user
      expect(response). to redirect_to(action: :index)
    end
  end
end
