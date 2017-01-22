class Ng::V1::Agent::TicketsController < Ng::V1::Agent::BaseController

  # Include
  include TicketsConcern

  # Filters
  before_action :set_ownership, only: [:update]

  private

  def set_tickets
    return @tickets = Ticket.all unless params[:mine] == "true"
    @tickets = Ticket.for_agent(current_agent.id)
  end

  def set_ownership
    case @ticket.agent
    when current_agent
      return
    when nil
      @ticket.agent = current_agent
    else
      render json: {
        error_message: 'Packages should be array'
      }, status: :not_found
    end
  end
end
