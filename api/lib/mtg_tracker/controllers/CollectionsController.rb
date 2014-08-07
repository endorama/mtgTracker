# -*- encoding: utf-8 -*-

require 'sinatra/base'

require_relative 'BaseController'

module MtgTracker
  class CollectionsController < BaseController

    get '/' do
      reply_with_message 'Collections'
    end
  end
end
