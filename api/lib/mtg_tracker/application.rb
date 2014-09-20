# -*- encoding: utf-8 -*-

require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/respond_with'

require_relative 'sinatra/error_handling'
# require_relative 'sinatra/reply'
# require_relative 'sinatra/request'

ActiveRecord::Base.include_root_in_json = true

module MtgTracker
  class Application < Sinatra::Base

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

    register ::Sinatra::RespondWith
    register ::Sinatra::ErrorHandling

    respond_to :json

    # helpers ::Sinatra::ReplyHelpers
    # helpers Sinatra::RequestHelpers

    def payload
      @payload
    end

    before do
      next unless request.post? or request.put?
      request.body.rewind
      # don't try to read request.body here, cause is a strem and you'll have to rewind it
      @payload = JSON.parse(request.body.read, symbolize_names: true)
    end

    get '/' do
      respond_with 'Hello World!'
    end
  end
end
