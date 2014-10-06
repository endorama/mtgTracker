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
      # http://stackoverflow.com/a/17049157
      set :allow_headers, [ 'X-Requested-With', 'X-HTTP-Method-Override', 'Content-Type', 'Cache-Control', 'Accept', 'Authorization' ]
    end

    respond_to :json

    # helpers ::Sinatra::ReplyHelpers
    # helpers Sinatra::RequestHelpers

    def payload
      @payload
    end

    # we need to force replying a status 200 to OPTIONS requests ( wtf?? )
    options '*' do
      status 200
    end

    before do
      next unless request.delete? or request.post? or request.put?
      request.body.rewind
      # don't try to read request.body here, cause is a strem and you'll have to rewind it
      begin
        @payload = JSON.parse(request.body.read, symbolize_names: true)
      rescue JSON::ParserError => e
        # prevent breaking from empty payload
        if e.message == 'A JSON text must at least contain two octets!'
          @payload = {}
        end
      end
    end

    retrieve_user do |user_id|
      User.find user_id
    end

    get '/' do
      respond_with 'Hello World!'
      # redirect_to '/app/'
    end

    get '/foo' do
      authorize!
      
      <<-ENDRESPONSE
        Ruby:    #{RUBY_VERSION}
        Rack:    #{Rack::VERSION}
        Sinatra: #{Sinatra::VERSION}
        #{@current_user.id} | #{@current_user.email} | #{@current_user.created_at}
      ENDRESPONSE
    end

  end
end
