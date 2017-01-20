class Ng::V1::Agent::BaseController < ApplicationController

  # Filters
  before_action :authenticate_agent!
end
