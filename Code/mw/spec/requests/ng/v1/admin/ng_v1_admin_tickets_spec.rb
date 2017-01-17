require 'rails_helper'

RSpec.describe "Ng::V1::Admin::Tickets", type: :request do
  describe "GET /ng_v1_admin_tickets" do
    it "works! (now write some real specs)" do
      get ng_v1_admin_tickets_path
      expect(response).to have_http_status(200)
    end
  end
end
