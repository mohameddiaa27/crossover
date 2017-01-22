class Ng::V1::Auth::SessionsController < Devise::SessionsController


  def create
    account = warden.authenticate!(auth_options)
    token = Tiddle.create_and_return_token(account, request)
    render json: {
      @scope => ActiveModelSerializers::SerializableResource.new(account),
      authentication_token: token }
  end

  def destroy
    Tiddle.expire_token(env['warden'].user, request) if env['warden'].user
    render json: {}
  end

  def failure
    render status: 401,
     json: { success: false,
             message: 'Login Failed' }
  end

  private

  # this is invoked before destroy and we have to override it
  def verify_signed_out_user
  end

  def auth_options
    @scope = params.keys.first.to_sym
    { scope: @scope, recall: "#{controller_path}#failure" }
  end
end
