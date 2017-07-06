require 'rails_helper'

RSpec.describe 'Meals API', type: :request do

  #initialize test data
  let!(:meals) { create_list(:meal, 1) }

  # Test for GET /meals
  describe 'GET /meals' do

    before { get '/meals' }

    it 'returns meals' do
      expect(json).not_to be_empty
      expect(json).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  # End test for GET /meals

  # Test for GET /meals/:id
  describe 'GET /meals/:id' do
    before { get '/meals/#{meal_id}' }

    context 'when the record exists' do
      it 'returns the meal' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(meal_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:meal_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Meal/)
      end
    end
  end
  # End test for GET /meals/:id

  # Test for POST /meals
  describe 'POST /meals' do
    # valid model
    let(:valid_attributes) { { name: "Caprese Salad", photo: "samplePhoto.png", rating: 4 } }
    let(:empty_name) { { name: "", photo: "samplePhoto.png", rating: '4' } }
    let(:empty_rating) { { name: "Caprese Salad", photo: "samplePhoto.png", rating: '' } }
    let(:invalid_rating) { { name: "Caprese Salad", photo: "samplePhoto.png", rating: '7' } }

    context 'when the request is valid' do
      before { post '/meals', params: valid_attributes }

      it 'creates a meal' do
        expect(json['name']).to eq('Caprese Salad')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid and user didnt enter a meal name' do
      before { post '/meals', params: empty_name}

      it 'returns status code of 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation error message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end

    context 'when the request is invalid and user didnt enter a rating' do
      before { post '/meals', params: empty_rating}

      it 'returns status code of 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation error message' do
        expect(response.body).to match(/Validation failed: Rating can't be blank/)
      end
    end

    context 'when the request is invalid and user entered a rating greater than 5' do
      before { post '/meals', params: invalid_rating}

      it 'returns status code of 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation error message' do
        expect(response.body).to match(/Validation failed: Rating can't be greater than 5/)
      end
    end
  end
  # End test for POST /meals

  # Test for PUT /meals/:id
  describe 'PUT /meals/:id' do
    let(:valid_attributes) { { name: 'Other Salad' } }

    context 'when the record exists' do
      before { put "/meals/#{meal_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
  # End test for PUT /meals/:id

  #  Test for DELETE /meals/:id
  describe 'DELETE /meals/:id' do
    before { delete "/meals/#{meal_id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
  # End test
end
