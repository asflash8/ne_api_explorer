module Web::Controllers::Explorer
  class Execute
    include Web::Action
    include UserInteractor::Util

    before :authenticate!
    expose :endpoints, :result

    def call(params)
      @endpoints = Endpoint.all_to_hash

      client = NeAPI::Master.new(
                 access_token: session["access_token"],
                 refresh_token: session["refresh_token"]
               )

      endpoint = params[:endpoint][:url]

      if @endpoints.values.include?(endpoint)
        request_params = {}

        query  = {query: JSON.parse(params[:endpoint][:query]).symbolize_keys} if params[:endpoint][:query].present?
        fields = {fields: params[:endpoint][:fields]} if params[:endpoint][:fields].present?

        request_params.merge!(query)  if query.present?
        request_params.merge!(fields) if fields.present?

        @result = JSON.pretty_generate(client.send(endpoint, request_params || {}))
      end
    end
  end
end
