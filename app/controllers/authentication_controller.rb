class AuthenticationController < ApplicationController

  def new
    if params[:client_id].present? && params[:client_secret].present?
      redirect_to ne_api_authenticate_url
    end
  end

  def create
    auth     = NeAPI::Auth.new(redirect_url: authentication_url)
    response = auth.ne_auth(params[:uid], params[:state])

    session[:access_token]  = response['access_token']
    session[:refresh_token] = response['refresh_token']

    redirect_to root_path
  end

  private
  def ne_api_authenticate_url
    "#{NeAPI::NE_SERVER_HOST}#{NeAPI::Auth::SIGN_IN_PATH}?client_id=#{params[:client_id]}&client_secret=#{params[:client_secret]}"
  end
end
