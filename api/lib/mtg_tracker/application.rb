# -*- encoding: utf-8 -*-

require 'sinatra/base'

require_relative './sinatra/reply'
require_relative './sinatra/request'

module MtgTracker
  class Application < Sinatra::Base

    set :logging, true
    set :dump_error, true
    set :raise_errors, true
    set :show_exceptions, true

    # set :bind, 'localhost'
    # set :port, 4567

    helpers Sinatra::ReplyHelpers
    helpers Sinatra::RequestHelpers

    not_found do
      reply_with_error 'URL not found', 404
    end

    get '/' do
      reply_with_message 'Hello World!'
    end
  end
end
