class Ng::V1::Customer::TicketsController < Ng::V1::Customer::BaseController

  # Include
  include TicketController

  # Filters
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /ng/v1/customer/tickets
  def index
    @tickets = Ticket.for_customer(current_customer.id)
    render json: @ticket
  end

  # POST /ng/v1/customer/tickets
  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      redirect_to @ticket, notice: 'Ticket was successfully created.'
    else
      render :new
    end
  end

  # DELETE /ng/v1/customer/tickets/1
  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: 'Ticket was successfully destroyed.'
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
