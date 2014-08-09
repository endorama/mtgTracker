# -*- encoding: utf-8 -*-

require 'sinatra/base'

require_relative '../application'
require_relative '../models/Collection'

module MtgTracker
  class CollectionsController < Application

    get '/' do
      items = MtgTracker::Collection.all
      respond_with collections: items
    end

    post '/' do
      reply_with_error 501
    end

    get '/:id' do
      unless params[:id].numeric?
        reply_with_error 422, 'Id should be numeric'
      end
      
      begin
        item = MtgTracker::Collection.find params[:id]
        reply_with({ collection: item })
      rescue ActiveRecord::RecordNotFound
        reply_with_error 404, "Can't find Collection with id #{params[:id]}"
      end
    end

    put '/:id' do
      reply_with_error 501
    end

    delete '/:id' do
      reply_with_error 501
    end
  end
end
