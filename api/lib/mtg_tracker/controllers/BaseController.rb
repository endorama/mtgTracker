
# require 'sinatra/base'

require_relative '../application'
require_relative '../sinatra/reply'
require_relative '../sinatra/request'

module MtgTracker
  class BaseController < Application

    helpers Sinatra::ReplyHelpers
    helpers Sinatra::RequestHelpers

  end
end
