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
      collection = MtgTracker::Collection.create!({ name: payload[:name] })
      respond_with collection: collection
    end

    get '/:id' do
      unless params[:id].numeric?
        halt_with_400 'Id should be numeric'
      end
      
      begin
        item = MtgTracker::Collection.find params[:id]
        reply_with({ collection: item })
      rescue ActiveRecord::RecordNotFound
        reply_with_error 404, "Can't find Collection with id #{params[:id]}"
      end
    end

    put '/:id' do
      halt_with_501
    end

    delete '/:id' do
      halt_with_501
    end
  end
end
