class TopController < ApplicationController
  ENDPOINTS = YAML.load_file("#{Rails.root}/config/api.yml")["endpoints"]

  before_action :authenticate_user!

  def show
    @endpoints = endpoints
  end

  def execute
    client = NeAPI::Master.new(
      access_token: session["access_token"],
      refresh_token: session["refresh_token"]
    )

    endpoint = api_params[:endpoint]
    if endpoints.values.include?(endpoint)
      request_params = {}

      query  = {query: JSON.parse(api_params[:query]).symbolize_keys} if api_params[:query].present?
      fields = {fields: api_params[:fields]} if api_params[:fields].present?

      request_params.merge!(query)  if query.present?
      request_params.merge!(fields) if fields.present?

      @result = client.send(endpoint, request_params || {}).to_json.html_safe
    end
  end

  private
  def endpoints
    ENDPOINTS.each_with_object({}){|(target, methods), obj|
      methods.map{|method, name| obj[name] = target + "_" + method}
    }
  end

  def api_params
    params.require(:api).permit([:endpoint, :fields, :query])
  end

  def authenticate_user!
    redirect_to authentication_new_url if session["access_token"].nil?
  end
end
