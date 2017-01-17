require 'rails_helper'

RSpec.describe "Ng::V1::Admin::Customers", type: :request do
  describe "GET /ng_v1_admin_customers" do
    it "works! (now write some real specs)" do
      get ng_v1_admin_customers_path
      expect(response).to have_http_status(200)
    end
  end
end
