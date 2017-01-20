class Ng::V1::Customer::BaseController < ApplicationController

  # Filters
  before_action :authenticate_customer!
end
