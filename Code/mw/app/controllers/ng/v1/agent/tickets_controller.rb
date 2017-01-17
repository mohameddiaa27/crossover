class Ng::V1::Agent::TicketsController < Ng::V1::Agent::BaseController

  # Include
  include TicketController

  # Filters
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /ng/v1/agent/tickets
  def index
    @tickets = Ticket.for_agent(current_agent.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ticket_params
      params.fetch(:ticket, {})
    end
end
