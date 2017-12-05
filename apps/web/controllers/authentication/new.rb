module Web::Controllers::Authentication
  class New
    include Web::Action

    def call(params)
      if params[:authentication] && params[:authentication][:client_id] && params[:authentication][:client_secret]
        redirect_to authentication_url
      end
    end

    private
    def authentication_url
      client_id          = params[:authentication][:client_id]
      client_secret      = params[:authentication][:client_secret]
      authentication_url = "#{NeAPI::NE_SERVER_HOST}#{NeAPI::Auth::SIGN_IN_PATH}?client_id=#{client_id}&client_secret=#{client_secret}"
    end
  end
end
