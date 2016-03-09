require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  subject(:user) { User.new(email: email, password: password, phone: phone, name: name, admin: admin) }

  let(:email) { "vanja@rbttt.com" }
  let(:password) { "12345rfvg" }
  let(:phone) { "0643335504" }
  let(:name) { "Vanja" }
  let(:admin) { 0 }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders login form' do
      get :new
      expect(response). to render_template :new
    end
  end

  describe 'POST #new' do
    before do
      create(:sanja)
      create(:not_admin)
    end

    it 'renders login page for wrong login params' do
      post :create, session: {email: "", password: ""}
      #assert_template 'sessions/new'
      expect(response).to render_template :new
    end

    it 'renders posts page for right login params for admin user' do
      post :create, session: {email: "vaca@rbt.com", password: "1234rtg"}
      #assert_template 'sessions/new'
      expect(response).to redirect_to(posts_path)
    end

    it 'renders home page for right login params for regular user' do
      post :create, session: {email: "vanja@rbttt.com", password: "12345rfvg"}
      #assert_template 'sessions/new'
      expect(response).to redirect_to(root_path)
    end

  end

  describe 'DELETE #destroy' do
    it 'renders home page' do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end

end
