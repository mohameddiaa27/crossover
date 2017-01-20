class Ng::V1::Auth::SessionsController < Devise::SessionsController


  def create
    account = warden.authenticate!(auth_options)
    token = Tiddle.create_and_return_token(account, request)
    render json: { @scope => account , authentication_token: token }
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

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   puts "8"*1000
  #   devise_parameter_sanitizer.permit(:user, keys: [:email, :password, :type])
  # end
end
