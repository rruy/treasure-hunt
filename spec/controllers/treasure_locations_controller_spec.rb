require 'rails_helper'

RSpec.describe Api::TreasuresController, type: :controller do
  let(:user) { create(:user) }

  before do
    token = user.create_new_auth_token['Authorization']
    request.headers['Authorization'] = token.to_s
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let!(:treasure) { create(:treasure) }

    it 'returns a success response' do
      get :show, params: { id: treasure.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new treasure location' do
        expect {
          post :create, params: { treasure: attributes_for(:treasure) }
        }.to change(Treasure, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        post :create, params: { treasure: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let!(:treasure) { create(:treasure) }

    context 'with valid parameters' do
      it 'updates the requested treasure location' do
        put :update, params: { id: treasure.to_param, treasure: { name: 'Updated Name' } }
        treasure.reload
        expect(treasure.name).to eq('Updated Name')
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        put :update, params: { id: treasure.to_param, treasure: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:treasure) { create(:treasure) }

    it 'destroys the requested treasure location' do
      expect {
        delete :destroy, params: { id: treasure.to_param }
      }.to change(Treasure, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
