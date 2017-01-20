# TicketsConcern:
# A module for warpping tickets common actions
module TicketsConcern
  extend ActiveSupport::Concern

  # Filters
  included do
    before_action :set_tickets, only: [:index]
    before_action :set_ticket, except: [:index]
    before_action :validate_presence, except: [:index, :create]
  end

  # Actions
  def show
    render json: @ticket, include: [:agent, :customer, :comments], status: :ok
  end

  def index
    @tickets.includes(:agent, :customer).page(params[:page]).per(10)
    render json: @tickets, include: [:agent, :customer], status: :ok
  end

  private

  def set_ticket
    @ticket = Ticket.find_by(id: params[:id] || params[:ticket_id])
  end

  # Error Responses
  def validate_presence
    return unless @ticket.nil?
    render json: {
      error_message: 'Ticket maybe deleted'
    }, status: :not_found
  end
end
