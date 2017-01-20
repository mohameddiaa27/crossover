class Ng::V1::Admin::BaseController < ApplicationController

  # Filters
  before_action :authenticate_admin!
end
