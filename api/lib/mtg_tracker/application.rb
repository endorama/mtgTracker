# -*- encoding: utf-8 -*-

require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/respond_with'
require 'sinatra/cross_origin'

require_relative 'sinatra/error_handling'
require_relative 'sinatra/authentication'
# require_relative 'sinatra/reply'
# require_relative 'sinatra/request'

module MtgTracker
  class Application < Sinatra::Base

    register ::Sinatra::RespondWith
    register ::Sinatra::ErrorHandling
    register ::Sinatra::CrossOrigin
    register ::Sinatra::Authentication

    configure do
      # Don't log them. We'll do that ourself
      disable :dump_errors
      # Don't capture any errors. Throw them up the stack
      enable :raise_errors
      # Disable internal middleware for presenting errors as useful HTML pages
      disable :show_exceptions
      # Default set by sinatra/activerecord
      # set :database_file, "../../config/database.yml"
    end

    configure :development do
      # enable cors request
      enable :cross_origin
      set :allow_origin, 'http://localhost:8000'
      set :allow_methods, [:delete, :get, :post, :put, :options]
      # set :allow_credentials, true
      # set :max_age, "1728000"
      set :expose_headers, ['Content-Type']
    end

    respond_to :json

    # helpers ::Sinatra::ReplyHelpers
    # helpers Sinatra::RequestHelpers

    def payload
      @payload
    end

    before do
      next unless request.delete? or request.post? or request.put?
      request.body.rewind
      # don't try to read request.body here, cause is a strem and you'll have to rewind it
      @payload = JSON.parse(request.body.read, symbolize_names: true)
    end

    get '/' do
      respond_with 'Hello World!'
    end
  end
end
