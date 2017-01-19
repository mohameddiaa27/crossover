require 'rails_helper'


RSpec.describe Ng::V1::Admin::TicketsController, type: :controller do

  before do
    @admin = Admin.create!(email: Faker::Internet.email, password: Faker::Name.unique.name, name: Faker::Name.name)
    @customer = Customer.create!(email: Faker::Internet.email, password: Faker::Name.unique.name, name: Faker::Name.name)
    @token = Tiddle.create_and_return_token(@admin, FakeRequest.new)
    sign_in @admin
  end

  let(:valid_attributes) {
    {
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph,
      customer: @customer
    }
  }

  before(:each) do
    @ticket = Ticket.create! valid_attributes
  end

  describe 'GET #index' do
    it 'assigns all tickets as @tickets' do
      puts '*'*1000
      p FactoryGirl.create(:ticket, :assigned, :random_agent, :solved)
      puts '*'*1000
      @Tickets = Ticket.limit(1)
      res = ActiveModelSerializers::SerializableResource.new(@Tickets, {include: [:customer]}).as_json
      params = {
        page: 1,
        format: :json
      }
      get :index, params: params
      expect(JSON.parse(response.body)).to include_json(res)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested ticket as @ticket' do
      get :show, params: { id: @ticket.to_param }
      expect(assigns(:ticket)).to eq(@ticket)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested ticket' do
      expect {
        delete :destroy, params: { id: @ticket.to_param }
      }.to change(Ticket, :count).by(-1)
    end
  end

end
