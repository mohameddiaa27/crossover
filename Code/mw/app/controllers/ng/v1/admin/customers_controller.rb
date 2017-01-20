class Ng::V1::Admin::CustomersController < Ng::V1::Admin::BaseController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /ng/v1/admin/customers
  def index
    @customers = Customer.all
  end

  # GET /ng/v1/admin/customers/1
  def show
  end

  # DELETE /ng/v1/admin/customers/1
  def destroy
    @customer.destroy
    redirect_to customers_url, notice: 'Customer was successfully destroyed.'
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
