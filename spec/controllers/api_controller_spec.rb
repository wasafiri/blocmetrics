require 'spec_helper'

describe EventsController, :type => :api do

  before do
    Timecop.freeze(Time.now)
  end

  after do
    Timecop.return
  end

  describe 'POST /events.json' do
    let(:app) { FactoryGirl.create :app }

    let(:params) do
      {
        event: {
          app_id: "#{app.id}",
          ip_address: '200.1.1.1',
          web_property_id: '100',
          action: 'some action'
        }
      }
    end

    let(:nonexistentapp_params) do
      {
        event: {
          app_id: "2",
          ip_address: '200.1.1.1',
          web_property_id: '100',
          action: 'some action'
        }
      }
    end

    subject do
      post :create, params, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    end

    it 'success' do
      subject
      expect(response).to be_success
    end

    it 'creates an event' do
      expect(Event.count).to eql 0
      subject
      expect(Event.count).to eql 1
      event = Event.first
      expect(event.app_id).to eql 1
      expect(event.ip_address).to eql '200.1.1.1'
      expect(event.web_property_id).to eql '100'
      expect(event.action).to eql 'some action'
    end

    it 'only processes events from registered apps' do
      expect {post :create, nonexistentapp_params, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
