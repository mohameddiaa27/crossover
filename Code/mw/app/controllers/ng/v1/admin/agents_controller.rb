class Ng::V1::Admin::AgentsController < Ng::V1::Admin::BaseController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  # GET /ng/v1/admin/agents
  def index
    @agents = Agent.page(params[:page]).per(5)
    render json: { users: @agents, meta: pagination_dict(@agents) }, status: :ok
  end

  # POST /ng/v1/admin/agents
  def create
    @agent = Agent.new(agent_params)
    @agent.password = '123456'
    if @agent.save
      render json: @agent, status: :ok
    else
      render json: {
        error_message: 'Ticket failed to update'
      }, status: :bad_request
    end
  end

  # PATCH/PUT /ng/v1/admin/agents/1
  def update
    if @agent.update(agent_params)
      render json: @agent, status: :ok
    else
      render json: {
        error_message: 'Ticket failed to update'
      }, status: :bad_request
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_agent
    @agent = Agent.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def agent_params
    params.fetch(:agent, {}).permit(:name, :email)
  end
end
