module Web::Controllers::Explorer
  class Index
    include Web::Action
    include UserInteractor::Util

    before :authenticate!
    expose :endpoints, :result

    def call(params)
      @endpoints = Endpoint.all.each_with_object({}){|(target, methods), obj|
        methods.map{|method, name| obj[name] = target + "_" + method}
      }
    end
  end
end
