require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe 'GET #index' do
    let(:user) { create(:user) }

    before do
      token = user.create_new_auth_token['Authorization']
      request.headers['Authorization'] = token.to_s
    end

    it 'returns a success response' do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }

    before do
      token = user.create_new_auth_token['Authorization']
      request.headers['Authorization'] = token.to_s
    end

    it 'returns a success response' do
      get :show, params: { id: user.to_param }
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post :create, params: { email: 'test@example.com', password: 'password', password_confirmation: 'password' }
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        post :create, params: { email: '', password: 'password', password_confirmation: 'password' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user) }

    before do
      token = user.create_new_auth_token['Authorization']
      request.headers['Authorization'] = token.to_s
    end

    context 'with valid parameters' do
      it 'updates the requested user' do
        put :update, params: { id: user.to_param, user: { name: 'Updated Name' } }
        user.reload
        expect(user.name).to eq('Updated Name')
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        put :update, params: { id: user.to_param, user: { email: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user_login) { create(:user) }
    let!(:user_delete) { create(:user) }

    before do
      token = user_login.create_new_auth_token['Authorization']
      request.headers['Authorization'] = token.to_s
    end

    it 'destroys the requested user' do
      expect {
        delete :destroy, params: { id: user_delete.to_param }
      }.to change(User, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end