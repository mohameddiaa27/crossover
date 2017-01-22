class Ng::V1::Customer::TicketsController < Ng::V1::Customer::BaseController

  # Include
  include TicketsConcern

  # POST /ng/v1/customer/tickets
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.customer = current_customer
    if @ticket.save
      render json: @ticket, include: [:agent, :customer, comments: :account], status: :ok
    else
      render json: @ticket.errors, status: :bad_request
    end
  end

  # DELETE /ng/v1/customer/tickets/1
  def destroy
    @ticket.destroy!
    render json: @ticket, status: :ok
  end

  private

  def set_ticket
    @ticket = Ticket.includes(comments: :account).find_by(id: params[:id], customer_id: current_customer.id)
  end

  def set_tickets
    @tickets = Ticket.for_customer(current_customer.id)
  end

  # Only allow a trusted parameter "white list" through.
  def ticket_params
    params.fetch(:ticket, {}).permit(:title, :body)
  end
end
