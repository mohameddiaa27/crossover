require 'rails_helper'

RSpec.describe Ng::V1::Admin::TicketsController, type: :controller do

  before do
    @admin  = FactoryGirl.create(:admin)
    @ticket = FactoryGirl.create(:ticket)
    sign_in @admin
  end

  before :each do
    accept_json
  end

  describe 'GET #index' do
    it 'assigns all tickets as @tickets' do
      res = model_serialize(Ticket.limit(10) , [:customer])
      get :index, params: { page: 1 }
      expect(response).to have_http_status(200)
      expect(response_body).to include_json(res)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested ticket as @ticket' do
      res = model_serialize(@ticket, [:agent, :customer, :comments])
      get :show, params: { id: @ticket.to_param }
      expect(response).to have_http_status(200)
      expect(response_body).to include_json(res)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested ticket' do
      expect {
        delete :destroy, params: { id: @ticket.to_param }
      }.to change(Ticket, :count).by(-1)
      expect(response).to have_http_status(200)
    end
  end
end
