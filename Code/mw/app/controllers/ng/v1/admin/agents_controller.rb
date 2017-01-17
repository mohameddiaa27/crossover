class Ng::V1::Admin::AgentsController < Ng::V1::Admin::BaseController
  before_action :set_agent, only: [:show, :edit, :update, :destroy]

  # GET /ng/v1/admin/agents
  def index
    @agents = Agent.all
  end

  # GET /ng/v1/admin/agents/1
  def show
  end

  # GET /ng/v1/admin/agents/new
  def new
    @agent = Agent.new
  end

  # GET /ng/v1/admin/agents/1/edit
  def edit
  end

  # POST /ng/v1/admin/agents
  def create
    @agent = Agent.new(agent_params)

    if @agent.save
      redirect_to @agent, notice: 'Agent was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ng/v1/admin/agents/1
  def update
    if @agent.update(agent_params)
      redirect_to @agent, notice: 'Agent was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ng/v1/admin/agents/1
  def destroy
    @agent.destroy
    redirect_to agents_url, notice: 'Agent was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent
      @agent = Agent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def agent_params
      params.fetch(:agent, {})
    end
end
