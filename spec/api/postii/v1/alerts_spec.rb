require 'rspec'
require 'rails_helper'

describe 'Postii::V1::Alerts' do

  context 'unauthorized' do
    before do
      # Do nothing
    end

    after do
      # Do nothing
    end

    context 'GET /api/v1/alerts' do
      it 'returns a list of all available alerts' do
        get '/api/v1/alerts'
        expect(response.status).to eq(401)
      end
    end

    context 'POST /api/v1/alerts' do
      it 'returns 401' do
        post '/api/v1/alerts'
        expect(response.status).to eq(401)
      end
    end

    context 'POST /api/v1/alerts/query' do
      it 'returns 401' do
        post '/api/v1/alerts/query'
        expect(response.status).to eq(401)
      end
    end
  end

  context 'authorized' do

    let!(:email) { "a@a.com" }
    let!(:password) { "Hello@123" }
    let!(:creator) { Creator.create!(creator_name: 'Test Alerts Creator', email_address: email, sector_code: 'test') }
    let!(:user) { User.create!(email: email, password: password, creator: creator) }

    before do
      post '/auth/login', params: { user: { email: email,password: password } }
      @token = response.headers["Authorization"]
    end

    context 'GET /api/v1/alerts' do
      it 'returns 200' do
        get '/api/v1/alerts', headers: { Authorization: @token }
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to be_a_kind_of(Array)
      end
    end

    context 'GET /api/v1/alerts/:id' do

      let!(:code) { 'TEST00000' }
      let!(:message) { 'Test message' }
      let!(:component) { 'test' }
      let!(:additional_note) { 'Just a test message' }
      let!(:alert) { ErrMsg.create_or_find_by!(err_code: code, message: message,
                                               component: component, additional_note: additional_note) }

      after do
        ErrMsg.destroy(alert.id) if ErrMsg.exists? err_code: alert.err_code
      end

      it 'returns exactly one error message with a matching id' do
        get "/api/v1/alerts/#{alert.id}", headers: { Authorization: @token }
        expect(response.status).to eq(200)
      end
    end

    context 'POST /api/v1/alerts' do

      let!(:uri ) { '/api/v1/alerts' }
      let!(:code) { 'TEST00000' }
      let!(:message) { 'Test message' }
      let!(:component) { 'test' }
      let!(:additional_note) { 'Just a test message' }

      before do
        if ErrMsg.exists? err_code: code
          ErrMsg.destroy_by(err_code: code)
        end
      end

      after do
        if ErrMsg.exists? err_code: code
          ErrMsg.destroy_by(err_code: code)
        end
      end

      it 'can create one alert message' do
        expect do
          post uri, params: { code: code, message: message, component: component, additional_note: additional_note },
               headers: { Authorization: @token }
          expect(response.status).to eq(201)
        end
          .to change(ErrMsg, :count).by(1)
      end
    end

    describe 'Alert update-ables' do
      let!(:uri) { '/api/v1/alerts' }
      let!(:code_before) { 'TEST00001' }
      let!(:code_after) { 'TEST00002' }
      let!(:message_before) { 'Message BEFORE update' }
      let!(:message_after) { 'Message AFTER update' }
      let!(:component_before) { 'before' }
      let!(:component_after) { 'after' }
      let!(:reason_before) { 'Reason BEFORE update' }
      let!(:reason_after) { 'Reason AFTER update' }
      let!(:additional_note_before) { 'Additional Note before' }
      let!(:additional_note_after) { 'Additional Note after' }

      before do
        @alert_sample = ErrMsg.create!(err_code: code_before, message: message_before,
                                                  component: component_before, reason: reason_before,
                                                  additional_note: additional_note_before)
      end

      after do
        ErrMsg.destroy(@alert_sample.id) if ErrMsg.exists? id: @alert_sample.id
      end

      context 'PUT /api/v1/alerts/:id' do
        it 'denies the update when params are insufficient' do
          put "#{uri}/#{@alert_sample.id}",
              params: {code: code_after, reason: reason_after},
              headers: { Authorization: @token }
          expect(response.status).to eq(400)
          alert = ErrMsg.find(@alert_sample.id)
          expect(alert.err_code).to eq(code_before)
          expect(alert.reason).to eq(reason_before)
        end

        it 'updates the whole alert message when all params are valid' do
          put "#{uri}/#{@alert_sample.id}",
              params: {code: code_after, message: message_after,
                       component: component_after, reason: reason_after, additional_note: additional_note_after},
              headers: { Authorization: @token }
          expect(response.status).to eq(201)
          alert = ErrMsg.find(@alert_sample.id)
          expect(alert.err_code).to eq(code_after)
          expect(alert.message).to eq(message_after)
          expect(alert.reason).to eq(reason_after)
          expect(alert.component).to eq(component_after)
          expect(alert.additional_note).to eq(additional_note_after)
        end
      end

      context 'PATCH /api/v1/alerts/:id' do
        it 'updates the alert message by code only' do
          patch "#{uri}/#{@alert_sample.id}", params: {code: code_after}, headers: { Authorization: @token }
          expect(response.status).to eq(201)
          alert = ErrMsg.find(@alert_sample.id)
          expect(alert.err_code).to eq(code_after)
          expect(alert.message).to eq(message_before)
          expect(alert.reason).to eq(reason_before)
          expect(alert.component).to eq(component_before)
          expect(alert.additional_note).to eq(additional_note_before)
        end

        it 'updates the alert message by message only' do
          patch "#{uri}/#{@alert_sample.id}", params: {message: message_after}, headers: { Authorization: @token }
          expect(response.status).to eq(201)
          alert = ErrMsg.find(@alert_sample.id)
          expect(alert.err_code).to eq(code_before)
          expect(alert.message).to eq(message_after)
          expect(alert.reason).to eq(reason_before)
          expect(alert.component).to eq(component_before)
          expect(alert.additional_note).to eq(additional_note_before)
        end

        it 'updates the alert message by reason only' do
          patch "#{uri}/#{@alert_sample.id}", params: {reason: reason_after}, headers: { Authorization: @token }
          expect(response.status).to eq(201)
          alert = ErrMsg.find(@alert_sample.id)
          expect(alert.err_code).to eq(code_before)
          expect(alert.message).to eq(message_before)
          expect(alert.reason).to eq(reason_after)
          expect(alert.component).to eq(component_before)
          expect(alert.additional_note).to eq(additional_note_before)
        end

        it 'updates the alert message by component only' do
          patch "#{uri}/#{@alert_sample.id}", params: {component: component_after}, headers: { Authorization: @token }
          expect(response.status).to eq(201)
          alert = ErrMsg.find(@alert_sample.id)
          expect(alert.err_code).to eq(code_before)
          expect(alert.message).to eq(message_before)
          expect(alert.reason).to eq(reason_before)
          expect(alert.component).to eq(component_after)
          expect(alert.additional_note).to eq(additional_note_before)
        end

        it 'updates the alert message by additional_note only' do
          patch "#{uri}/#{@alert_sample.id}", params: {additional_note: additional_note_after},
                headers: { Authorization: @token }
          expect(response.status).to eq(201)
          alert = ErrMsg.find(@alert_sample.id)
          expect(alert.err_code).to eq(code_before)
          expect(alert.message).to eq(message_before)
          expect(alert.reason).to eq(reason_before)
          expect(alert.component).to eq(component_before)
          expect(alert.additional_note).to eq(additional_note_after)
        end
      end

    end

    context 'DELETE /api/v1/alerts/:id' do
      let!(:uri ) { '/api/v1/alerts' }
      let!(:code) { 'TEST00000' }
      let!(:message) { 'Test message' }
      let!(:component) { 'test' }
      let!(:additional_note) { 'Just a test message' }
      let!(:alert) { ErrMsg.create_or_find_by!(err_code: code, message: message,
                                               component: component, additional_note: additional_note) }

      it 'deletes the message with the id' do
        expect do
          delete "/api/v1/alerts/#{alert.id}", headers: { Authorization: @token }
          expect(response.status).to eq(200)
        end
          .to change(ErrMsg, :count).by(-1)
      end
    end

    context 'POST /api/v1/alerts/query' do

      let!(:uri) { '/api/v1/alerts/query' }
      let!(:code) { 'TEST00000' }
      let!(:message) { 'Test' }
      let!(:component) { 'core' }
      let!(:alert) { ErrMsg.create_or_find_by!(err_code: code, message: message,
                                               reason: message, component: component) }

      after do
        ErrMsg.delete_by(err_code: code)
      end

      it 'can find an alert via id' do
        post uri, params: { id: alert.id }, headers: { Authorization: @token }
        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)["id"]).to eq(alert.id)
      end

      it 'can find an alert via code' do
        post uri, params: { code: code }, headers: { Authorization: @token }
        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)["err_code"]).to eq(code)
        expect(JSON.parse(response.body)["message"]).to eq(message)
      end

      it 'can find alerts via component' do
        post uri, params: { component: component }, headers: {Authorization: @token}
        expect(response.status).to eq(201)
        response_body = JSON.parse(response.body)
        expect(response_body).to be_a_kind_of(Array)
        expect(response_body.all? { |alert| alert["component"] == component }).to be_truthy
      end
    end
  end

end
