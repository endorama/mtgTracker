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
      
      item = MtgTracker::Collection.find params[:id]
      respond_with collection: item
    end

    put '/:id' do
      halt_with_501
    end

    delete '/:id' do
      halt_with_501
    end
  end
end
