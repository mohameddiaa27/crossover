# TicketsConcern:
# A module for warpping tickets common actions
module TicketsConcern
  extend ActiveSupport::Concern

  # Filters
  included do
    before_action :set_tickets, only: [:index]
    before_action :filter_params, only: [:index]
    before_action :set_ticket, except: [:index, :last_month]
    before_action :validate_presence, except: [:index, :create, :last_month]
  end

  # Actions
  def show
    render json: @ticket, include: [:agent, :customer, comments: :account], status: :ok
  end

  def index
    @tickets = @tickets.includes(:agent, :customer).page(params[:page]).per(5)
    render json: @tickets, include: [:agent, :customer], meta: pagination_dict(@tickets), adapter: :json, status: :ok
  end

  def update
    if @ticket.update(update_params)
      render json: @ticket, include: [:agent, :customer, comments: :account], status: :ok
    else
      render json: {
        error_message: 'Ticket failed to update'
      }, status: :bad_request
    end
  end

  private

  def ticket_params
    params.fetch(:ticket, {}).permit(:status)
  end

  def update_params
    params.fetch(:ticket, {}).permit(:status)
  end

  def set_ticket
    @ticket = Ticket.includes(comments: :account).find_by(id: params[:id] || params[:ticket_id])
  end

  def filter_params
    filters = {}
    if params[:status] and params[:status] != 'all'
      filters[:status] = params[:status]
    end
    @tickets = @tickets.where(filters)
  end

  # Error Responses
  def validate_presence
    return unless @ticket.nil?
    render json: {
      error_message: 'Ticket maybe deleted'
    }, status: :not_found
  end

end
