# -*- encoding: utf-8 -*-

require_relative '../application'
require_relative '../models/Collection'

module MtgTracker
  class CollectionsController < Application

    get '/' do
      items = Collection.all
      respond_with collections: items
    end

    post '/' do
      collection = Collection.create!({ name: payload[:name] })
      respond_with collection
    end

    get '/:id' do
      unless params[:id].numeric?
        halt_with_400 'Id should be numeric'
      end
      
      item = Collection.find params[:id]
      respond_with item
    end

    put '/:id' do
      collection = Collection.find(params[:id])
      collection = Collection.update(collection.id, payload)
      respond_with collection

    end

    delete '/:id' do
      halt_with_501
    end
  end
end
