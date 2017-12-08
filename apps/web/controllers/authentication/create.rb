module Web::Controllers::Authentication
  class Create
    include Web::Action
    include UserInteractor::Util

    def call(params)
      auth     = NeAPI::Auth.new(redirect_url: authentication_url)
      response = auth.ne_auth(params[:uid], params[:state])

      session[:access_token]  = response['access_token']
      session[:refresh_token] = response['refresh_token']

      redirect_to '/'
    end
  end
end
