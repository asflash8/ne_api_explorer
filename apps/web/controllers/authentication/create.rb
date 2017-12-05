module Web::Controllers::Authentication
  class Create
    include Web::Action

    def call(params)
      auth     = NeAPI::Auth.new(redirect_url: authentication_url)
      response = auth.ne_auth(params[:uid], params[:state])

      session[:access_token]  = response['access_token']
      session[:refresh_token] = response['refresh_token']

      redirect_to '/'
    end

    private
    def authentication_url
      client_id          = params[:client_id]
      client_secret      = params[:client_secret]
      authentication_url = "#{NeAPI::NE_SERVER_HOST}#{NeAPI::Auth::SIGN_IN_PATH}?client_id=#{client_id}&client_secret=#{client_secret}"
    end
  end
end
