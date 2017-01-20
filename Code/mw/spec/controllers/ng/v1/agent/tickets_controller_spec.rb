require 'rails_helper'


RSpec.describe Ng::V1::Agent::TicketsController, type: :controller do

  let(:agent) { FactoryGirl.create(:agent) }
  let(:ticket) { FactoryGirl.create(:ticket) }
  let(:another_agent) { FactoryGirl.create(:another_agent) }

  before do
    sign_in agent
  end

  before :each do
    accept_json
  end

  describe 'GET #index' do
    subject { Ticket.for_agent(agent).limit(10) }
    it 'assigns all tickets as tickets' do
      res = model_serialize(subject, [:customer])
      get :index, params: { page: 1 }
      expect(response).to have_http_status(:ok)
      expect(response_body).to include_json(res)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested ticket as ticket' do
      res = model_serialize(ticket, [:agent, :customer, :comments])
      get :show, params: { id: ticket.to_param }
      expect(response).to have_http_status(:ok)
      expect(response_body).to include_json(res)
    end
  end

  describe 'PUT #assign' do
    let(:params) { { ticket_id: ticket.to_param } }
    it 'assigns the requested ticket current_agent' do
      put :assign, params: params
      expect(assigns(:ticket).agent).to eq(agent)
    end

    it 'fails to assign the requested ticket current_agent' do
      ticket.assign!(another_agent)
      put :assign, params: params
      expect(response).to have_http_status(:bad_request)
      expect(assigns(:ticket).agent).not_to eq(agent)
    end
  end
end
