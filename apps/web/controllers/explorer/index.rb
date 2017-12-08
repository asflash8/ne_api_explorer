module Web::Controllers::Explorer
  class Index
    include Web::Action
    include UserInteractor::Util

    before :authenticate!
    expose :endpoints, :result

    def call(params)
      @endpoints = Endpoint.all_to_hash
    end
  end
end
