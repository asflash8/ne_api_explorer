module UserInteractor
  module Util
    def authenticate!
      result = UserInteractor::Authenticator.new(session).call
      if result.failure?
        redirect_to '/authentication/new'
      end
    end

    def authentication_url
      authentication_url = "#{NeAPI::NE_SERVER_HOST}#{NeAPI::Auth::SIGN_IN_PATH}?client_id=#{client_id}&client_secret=#{client_secret}"
    end
    
    private
    def client_id
      return params[:client_id] if params[:client_id].present?
      return params[:authentication][:client_id] if params[:authentication].present?
    end
    
    def client_secret
      return params[:client_secret] if params[:client_secret].present?
      return params[:authentication][:client_secret] if params[:authentication].present?
    end
  end
end
