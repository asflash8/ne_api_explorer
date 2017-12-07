module Web::Controllers::Authentication
  class New
    include Web::Action
    include UserInteractor::Util

    def call(params)
      if params[:authentication] && params[:authentication][:client_id] && params[:authentication][:client_secret]
        redirect_to authentication_url
      end
    end
  end
end
