require 'rails_helper'

RSpec.describe Ng::V1::Customer::TicketsController, type: :controller do

  before do
    @ticket           = FactoryGirl.create(:ticket)
    @customer         = @ticket.customer
    @another_customer = FactoryGirl.create(:another_customer)
    @another_ticket   = FactoryGirl.create(:ticket, customer: @another_customer)
    sign_in @customer
  end

  let(:tickets) {  Ticket.for_customer(@customer).limit(10) }
  let(:other_tickets) { Ticket.for_customer(@another_customer).limit(10) }
  let(:valid_params) {
    {
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph
    }
  }
  before :each do
    accept_json
  end

  describe 'GET #index' do
    it 'assigns all tickets as @tickets' do
      res = model_serialize(tickets, [:customer])
      get :index, params: { page: 1 }
      expect(response).to have_http_status(200)
      expect(response_body).to include_json(res)
    end

    it 'should not include another_ticket' do
      get :index, params: { page: 1 }
      expect(response).to have_http_status(200)
      ids = response_body.map{|t| t['id']}
      expect(ids).not_to eq(other_tickets.pluck(:id))
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

    it 'fails to destroy unowned ticket' do
      delete :destroy, params: { id: @another_ticket.to_param }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Ticket" do
        expect {
          post :create, params: {ticket: valid_params}
        }.to change(Ticket, :count).by(1)
        # TODO CHECK FOR RESPONSE
        expect(response).to have_http_status(:ok)
      end

      it "assigns a newly created ticket as @ticket" do
        post :create, params: {ticket: valid_params}
        expect(assigns(:ticket)).to be_a(Ticket)
        expect(assigns(:ticket)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved ticket as @ticket" do
        post :create, params: {ticket: {}}
        expect(assigns(:ticket)).to be_a_new(Ticket)
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

end
