require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include SessionsHelper
  before do
    @user = FactoryGirl.create(:not_admin)
    @user2 = FactoryGirl.create(:sanja)
    @users = [@user2, @user]
    log_in(@user2)
  end
  after do
    log_out
  end
  describe 'GET #index' do

    context 'when is admin' do
      it 'renders the index view' do
        get :index
        expect(response).to render_template :index
      end

      it 'shows all users' do
        get :index
        expect(assigns(:users)).to eq(@users)
      end
    end

    context 'when is not admin' do
      before do
        log_out
        log_in(@user)
      end
      after do
        log_out
        log_in(@user2)
      end
      it 'dont render the index view' do
        get :index
        expect(response).not_to render_template :index
      end

      it 'dont show all users' do
        get :index
        expect(assigns(:users)).not_to eq(@users)
      end
    end

  end

  describe 'GET #show' do

    context 'when is admin' do
      it 'renders the show view' do
        get :show, id: @user
        expect(response).to render_template :show
      end

      it 'shows specific user' do
        get :show, id: @user
        expect(assigns(:user)).to eq(@user)
      end
    end

    context 'when is not admin' do
      before do
        log_out
        log_in(@user)
      end
      after do
        log_out
        log_in(@user2)
      end
      it 'dont render the show view' do
        get :show, id: @user
        expect(response).not_to render_template :show
      end

      it 'dont show specific user' do
        get :show, id: @user
        expect(assigns(:user)).not_to eq(@user)
      end
    end

  end

  describe 'GET #edit' do
    context 'when is not current user' do
      before do
        log_out
        log_in(@user)
      end
      after do
        log_out
        log_in(@user2)
      end
      it 'dont render the edit view' do
        get :edit, id: @user2
        expect(response).not_to render_template :edit
      end

      it 'dont show specific user' do
        get :edit, id: @user2
        expect(assigns(:user)).not_to eq(@user)
      end
    end

    context 'when is current user' do
      before do
        log_out
        log_in(@user)
      end
      after do
        log_out
        log_in(@user2)
      end
      it 'renders the edit view' do
        get :edit, id: @user
        expect(response).to render_template :edit
      end

      it 'shows specific user' do
        get :edit, id: @user
        expect(assigns(:user)).to eq(@user)
      end
    end

    context 'when is admin user' do
      it 'renders the edit view' do
        get :edit, id: @user2
        expect(response).to render_template :edit
      end

      it 'shows specific user' do
        get :edit, id: @user2
        expect(assigns(:user)).to eq(@user2)
      end
    end

  end

  describe 'PATCH #update' do

    context 'when is current user' do
      before do
        log_out
        log_in(@user)
      end
      after do
        log_out
        log_in(@user2)
      end
      context 'when params are not valid' do
        it 'dont update specific user' do
          patch :update, id: @user.id, user: attributes_for(:not_admin, email: "vaab")
          @user.reload
          expect(@user.email).not_to eq("vaab")
        end
        it 'render edit page' do
          patch :update, id: @user.id, user: attributes_for(:not_admin, email: "vaab")
          expect(response).to render_template :edit
        end
      end

      context 'when params are valid' do
        it 'update specific user' do
          patch :update, id: @user.id, user: attributes_for(:not_admin, name: "Vanja Vanjaa")
          @user.reload
          expect(@user.name).to eq("Vanja Vanjaa")
        end

        it 'renders that user page' do
          patch :update, id: @user, user: attributes_for(:not_admin, name: "Vanja Vanjaa")
          @user.reload
          expect(response).to redirect_to(action: :show)
        end
      end
    end

    context 'when is admin' do
      context 'when params are not valid' do
        it 'dont update specific user' do
          patch :update, id: @user.id, user: attributes_for(:not_admin, email: "vaab")
          @user.reload
          expect(@user.email).not_to eq("vaab")
        end
        it 'render edit page' do
          patch :update, id: @user.id, user: attributes_for(:not_admin, email: "vaab")
          expect(response).to render_template :edit
        end
      end

      context 'when params are valid' do
        it 'update specific user' do
          patch :update, id: @user.id, user: attributes_for(:not_admin, name: "Vanja Vanjaa")
          @user.reload
          expect(@user.name).to eq("Vanja Vanjaa")
        end

        it 'renders that user page' do
          patch :update, id: @user, user: attributes_for(:not_admin, name: "Vanja Vanjaa")
          @user.reload
          expect(response).to redirect_to(action: :show)
        end
      end
    end

    context 'when is not current user' do
      before do
        log_out
        log_in(@user)
      end
      after do
        log_out
        log_in(@user2)
      end
      context 'when params are not valid' do
        it 'dont update specific user' do
          patch :update, id: @user2.id, user: attributes_for(:not_admin, email: "vaab")
          @user2.reload
          expect(@user2.email).not_to eq("vaab")
        end
        it 'dont render edit page' do
          patch :update, id: @user2.id, user: attributes_for(:sanja, email: "vaab")
          expect(response).not_to render_template :edit
        end
        it 'render home page' do
          patch :update, id: @user2.id, user: attributes_for(:sanja, email: "vaab")
          expect(response).to redirect_to root_path
        end
      end

      context 'when params are valid' do
        it 'dont update specific user' do
          patch :update, id: @user2.id, user: attributes_for(:not_admin, email: "vaab")
          @user2.reload
          expect(@user2.email).not_to eq("vaab")
        end
        it 'dont render edit page' do
          patch :update, id: @user2.id, user: attributes_for(:sanja, email: "vaab")
          expect(response).not_to render_template :edit
        end
        it 'render home page' do
          patch :update, id: @user2.id, user: attributes_for(:sanja, email: "vaab")
          expect(response).to redirect_to root_path
        end
      end
    end

  end

  describe 'DELETE #destroy' do
    context 'when is admin' do
      it 'delete selected user' do
        delete :destroy, id: @user2
        expect(User.exists?(@user2.id)).to be_falsey
      end

      it 'expect to render index page' do
        delete :destroy, id: @user
        expect(response). to redirect_to(action: :index)
      end
    end
    context 'when is not admin' do
      before do
        log_out
        log_in(@user)
      end
      after do
        log_out
        log_in(@user2)
      end
      it 'dont delete selected user' do
        delete :destroy, id: @user2
        expect(User.exists?(@user2.id)).not_to be_falsey
      end

      it 'dont expect to render index page' do
        delete :destroy, id: @user
        expect(response).not_to redirect_to(action: :index)
      end
    end

  end
end
