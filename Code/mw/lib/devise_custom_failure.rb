  class DeviseCustomFailure < Devise::FailureApp
    def respond
      if http_auth?
        http_auth
      end
    end
  end