module Web::Controllers::Explorer
  class Index
    include Web::Action

    before :authenticate!
    expose :endpoints

    def call(params)
      @endpoints = Endpoint.all.each_with_object({}){|(target, methods), obj|
        methods.map{|method, name| obj[name] = target + "_" + method}
      }
    end

    private
    def authenticate!
      result = UserInteractor::Authenticator.new(session).call
      if result.failure?
        redirect_to '/authentication/new'
      end
    end
  end
end
