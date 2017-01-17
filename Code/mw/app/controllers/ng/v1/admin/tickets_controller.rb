class Ng::V1::Admin::TicketsController < Ng::V1::Admin::BaseController

  #include
  include TicketController

  # Filters
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /ng/v1/admin/tickets
  def index
    @tickets = Ticket.all
  end

  # DELETE /ng/v1/admin/tickets/1
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
