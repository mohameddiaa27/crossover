module TicketController
  extend ActiveSupport::Concern

  module ClassMethods

    def show
    	render json: @ticket
    end

  end
end