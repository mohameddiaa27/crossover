class Ng::V1::Admin::CustomersController < Ng::V1::Admin::BaseController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /ng/v1/admin/customers
  def index
    @customers = Customer.all
  end

  # GET /ng/v1/admin/customers/1
  def show
  end

  # GET /ng/v1/admin/customers/new
  def new
    @customer = Customer.new
  end

  # GET /ng/v1/admin/customers/1/edit
  def edit
  end

  # POST /ng/v1/admin/customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to @customer, notice: 'Customer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ng/v1/admin/customers/1
  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: 'Customer was successfully updated.'
    else
      render :edit
    end
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
