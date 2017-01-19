require 'rails_helper'


RSpec.describe Ng::V1::Agent::TicketsController, type: :controller do

  before do
    @agent = Agent.create!(email: Faker::Internet.email, password: Faker::Name.unique.name, name: Faker::Name.name)
    @customer = Customer.create!(email: Faker::Internet.email, password: Faker::Name.unique.name, name: Faker::Name.name)
    @token = Tiddle.create_and_return_token(@agent, FakeRequest.new)
    sign_in @agent
  end

  let(:valid_attributes) {
    {
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph,
      customer: @customer
    }
  }

  let(:new_agent) {
    Agent.create!(email: Faker::Internet.email, password: Faker::Name.unique.name, name: Faker::Name.name)
  }

  before(:each) do
    @ticket = Ticket.create! valid_attributes
  end

  describe 'GET #index' do
    it 'assigns all tickets as @tickets' do
      params = {
        page: 1,
        filter: 'all',
        format: :json
      }
      get :index, params: params
      expect(assigns(:tickets)).to eq([@ticket])
    end

    it 'assigns only agent tickets as @tickets' do
      @ticket.assign!(@agent)
      params = {
        page: 1,
        format: :json
      }
      get :index, params: params
      expect(assigns(:tickets)).to eq([@ticket])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested ticket as @ticket' do
      get :show, params: { id: @ticket.to_param }
      expect(assigns(:ticket)).to eq(@ticket)
    end
  end

  describe 'POST #assign' do
    it 'assigns the requested ticket current_agent' do
      params = { ticket_id: @ticket.to_param }
      post :assign, params: params
      expect(assigns(:ticket).agent).to eq(@agent)
    end

    it 'fails to assign the requested ticket current_agent' do
      @ticket.assign!(new_agent)
      params = { ticket_id: @ticket.to_param }
      post :assign, params: params
      expect(assigns(:ticket).agent).to eq(new_agent)
    end
  end
end
