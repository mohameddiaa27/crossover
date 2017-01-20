class Ng::V1::Agent::TicketsController < Ng::V1::Agent::BaseController

  # Include
  include TicketsConcern

  # Filters
  before_action :validate_ownership, only: [:solve]

  def assign
    if @ticket.assign!(current_agent)
      render json: @ticket, include: [:agent, :customer, :comments], status: :ok
    else
      render json: { error_message: 'Ticket is already Assigned' }, status: :bad_request
    end
  end

  def solve
  end

  private

  def set_tickets
    return @tickets = Ticket.all if params[:filter] == 'all'
    @tickets = Ticket.for_agent(current_agent.id)
  end

  def validate_ownership
    return if @ticket.agent == current_agent
    render json: {
      error_message: 'Packages should be array'
    }, status: :not_found
  end
end
