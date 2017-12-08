require 'hanami/interactor'

module UserInteractor
  class Authenticator
    include Hanami::Interactor

    def initialize(session)
      @session = session
    end

    def call
    end

    private
    def valid?
      @session[:access_token].present? && @session[:refresh_token].present?
    end
  end
end
