module Web::Controllers::Concerns
  module AuthFilter
    def authenticate!
      result = UserInteractor::Authenticator.new(session).call
      if result.failure?
        redirect_to '/authentication/new'
      end
    end
  end
end
