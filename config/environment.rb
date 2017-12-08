require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/ne_api_explorer'
require_relative '../apps/web/application'

Hanami.configure do
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/ne_api_explorer_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/ne_api_explorer_development'
    #    adapter :sql, 'mysql://localhost/ne_api_explorer_development'
    #
    adapter :sql, ENV['DATABASE_URL']

    ##
    # Migrations
    #
    # migrations 'db/migrations'
    # schema     'db/schema.sql'
  end

  mailer do
    root 'lib/ne_api_explorer/mailers'

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: [:client_secret]

    mailer do
      delivery :smtp, address: ENV['SMTP_HOST'], port: ENV['SMTP_PORT']
    end
  end
end
