class Ng::V1::Admin::CustomersController < Ng::V1::Admin::BaseController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /ng/v1/admin/customers
  def index
    @customers = Customer.page(params[:page]).per(5)
    render json: { users: @customers, meta: pagination_dict(@customers) }, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def customer_params
    params.fetch(:customer, {})
  end
end
