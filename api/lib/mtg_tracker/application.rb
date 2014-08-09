# -*- encoding: utf-8 -*-

require 'sinatra/base'
require 'sinatra/activerecord'
require 'json'
require 'sinatra/json'
require 'sinatra/respond_with'

require_relative 'sinatra/error_handling'
# require_relative 'sinatra/reply'
# require_relative 'sinatra/request'

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

    helpers ::Sinatra::JSON

    register ::Sinatra::RespondWith
    register ::Sinatra::ErrorHandling

    respond_to :json

    # helpers ::Sinatra::ReplyHelpers
    # helpers Sinatra::RequestHelpers


    not_found do
      reply_with_error 404
    end

    get '/' do
      reply_with_message 'Hello World!'
    end
  end
end
