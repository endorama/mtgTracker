# -*- encoding: utf-8 -*-

require 'sinatra/base'
require 'sinatra/activerecord'

require_relative './sinatra/reply'
require_relative './sinatra/request'

module MtgTracker
  class Application < Sinatra::Base

    set :logging, true # or :logging, nil and env['rack.logger'] = logger
    set :dump_error, true
    set :raise_errors, true
    set :show_exceptions, true

    # set :bind, 'localhost'
    # set :port, 4567

    set :database_file, "../../config/database.yml"

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
