require "rails_helper"

RSpec.describe Ng::V1::Admin::AgentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ng/v1s").to route_to("ng/v1s#index")
    end

    it "routes to #new" do
      expect(:get => "/ng/v1s/new").to route_to("ng/v1s#new")
    end

    it "routes to #show" do
      expect(:get => "/ng/v1s/1").to route_to("ng/v1s#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ng/v1s/1/edit").to route_to("ng/v1s#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ng/v1s").to route_to("ng/v1s#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ng/v1s/1").to route_to("ng/v1s#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ng/v1s/1").to route_to("ng/v1s#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ng/v1s/1").to route_to("ng/v1s#destroy", :id => "1")
    end

  end
end
