# -*- encoding: utf-8 -*-

require 'sinatra/base'
require 'sinatra/activerecord'
require 'json'
require 'sinatra/json'
require 'sinatra/respond_with'

# require_relative 'sinatra/reply'
# require_relative 'sinatra/request'

module MtgTracker
  class Application < Sinatra::Base

    set :logging, true # or :logging, nil and env['rack.logger'] = logger
    set :dump_error, true
    set :raise_errors, true
    set :show_exceptions, true

    helpers ::Sinatra::JSON

    # set :bind, 'localhost'
    # set :port, 4567
    register ::Sinatra::RespondWith

    set :database_file, "../../config/database.yml"
    respond_to :json

    helpers Sinatra::ReplyHelpers
    helpers Sinatra::RequestHelpers

    not_found do
      reply_with_error 404
    end

    get '/' do
      reply_with_message 'Hello World!'
    end
  end
end
