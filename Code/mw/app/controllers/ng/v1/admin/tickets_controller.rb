class Ng::V1::Admin::TicketsController < Ng::V1::Admin::BaseController

  # Include
  include TicketsConcern

  # DELETE /ng/v1/admin/tickets/1
  def destroy
    @ticket.destroy
    render json: @ticket, status: :ok
  end

  private

  def set_tickets
    @tickets = Ticket.all
  end
end
