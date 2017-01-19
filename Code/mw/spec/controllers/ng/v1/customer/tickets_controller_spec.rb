require 'rails_helper'

RSpec.describe Ng::V1::Customer::TicketsController, type: :controller do

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

  let(:invalid_attributes) {
    {
      title: nil,
      body: Faker::Lorem.paragraph,
      customer: @customer
    }
  }


  describe 'GET #index' do
    it 'assigns all tickets as @tickets' do
      ticket = Ticket.create! valid_attributes
      params = {
        page: 1,
        format: :json
      }
      get :index, params: params
      expect(assigns(:tickets)).to eq([ticket])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested ticket as @ticket' do
      ticket = Ticket.create! valid_attributes
      get :show, { id: ticket.to_param }
      expect(assigns(:ticket)).to eq(ticket)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested ticket' do
      ticket = Ticket.create! valid_attributes
      expect {
        delete :destroy, params: { id: ticket.to_param }
      }.to change(Ticket, :count).by(-1)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Ticket" do
        expect {
          post :create, params: {ng_v1: valid_attributes}, session: valid_session
        }.to change(Ticket, :count).by(1)
      end

      it "assigns a newly created ng_v1 as @ng_v1" do
        post :create, params: {ng_v1: valid_attributes}, session: valid_session
        expect(assigns(:ng_v1)).to be_a(Ticket)
        expect(assigns(:ng_v1)).to be_persisted
      end

      it "redirects to the created ng_v1" do
        post :create, params: {ng_v1: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Ticket.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved ng_v1 as @ng_v1" do
        post :create, params: {ng_v1: invalid_attributes}, session: valid_session
        expect(assigns(:ng_v1)).to be_a_new(Ticket)
      end

      it "re-renders the 'new' template" do
        post :create, params: {ng_v1: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

end
