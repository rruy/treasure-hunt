# require 'rails_helper'

# RSpec.describe Api::WinnersController, type: :controller do
#   let(:user) { create(:user) }

#   describe 'GET #index' do
#     context 'when user is authenticated' do
#       before do
#         allow(controller).to receive(:authenticate_user!).and_return(true)
#         allow(controller).to receive(:current_user).and_return(user)
#       end

#       it 'returns a list of winners sorted by distance in ascending order' do
#         winners = create_list(:user, 3, winner: true)
#         get :index
#         result = JSON.parse(response.body)

#         expect(response).to have_http_status(:success)
#         expect(result['data'].size).to eq(3)
#       end

#       it 'paginates the list of winners' do
#         create_list(:user, 10, winner: true)
#         get :index, params: { page: 2, per_page: 5 }
#         result = JSON.parse(response.body)

#         expect(response).to have_http_status(:success)
#         expect(result['data'].size).to eq(5)
#       end
#     end

#     context 'when user is not authenticated' do
#       before do
#         allow(controller).to receive(:authenticate_user!).and_raise(StandardError)
#       end

#       it 'returns unauthorized status' do
#         get :index
#         expect(response).to have_http_status(:unauthorized)
#       end
#     end
#   end
# end

require 'rails_helper'

RSpec.describe Api::WinnersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'when authenticated' do
      before do
        token = user.create_new_auth_token['Authorization']
        request.headers['Authorization'] = token.to_s
      end

      it 'returns a successful response' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it 'returns JSON data of winners sorted by distance in ascending order by default' do
        create_list(:user, 5, distance: 10, winner: true)
        get :index

        winners = JSON.parse(response.body)['data']

        expect(winners.length).to eq(5)
        expect(winners.first['attributes']['distance']).to be <= winners.last['attributes']['distance']
      end

      it 'allows sorting winners by a specified column and direction' do
        create_list(:user, 5, distance: 10, winner: true)
        get :index, params: { sort: 'distance', direction: 'desc' }

        winners = JSON.parse(response.body)['data']
        expect(winners.first['attributes']['distance']).to be >= winners.last['attributes']['distance']
      end

      it 'paginates the results' do
        create_list(:user, 15, winner: true)
        get :index, params: { page: 2, per_page: 10 }
        winners = JSON.parse(response.body)['data']

        expect(winners.length).to eq(5)
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized status' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end