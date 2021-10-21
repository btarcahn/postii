require 'rspec'
require 'rails_helper'

describe 'PostiiAPI' do
  before do
    # Do nothing
  end

  after do
    # Do nothing
  end

  context 'GET /api/v1' do
    it 'returns 200' do
      get '/api/v1'
      expect(response.status).to eq(200)
    end
  end

  context 'POST /api/v1' do
    it 'returns 400' do
      post '/api/v1'
      expect(response.status).to eq(400)
    end
  end

  context 'PUT /api/v1' do
    it 'returns 400' do
      put '/api/v1'
      expect(response.status).to eq(400)
    end
  end

  context 'PATCH /api/v1' do
    it 'returns 400' do
      patch '/api/v1'
      expect(response.status).to eq(400)
    end
  end

  context 'DELETE /api/v1' do
    it 'returns 400' do
      delete '/api/v1'
      expect(response.status).to eq(400)
    end
  end
end
