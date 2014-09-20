# -*- encoding: utf-8 -*-

require_relative '../application'
require_relative '../models/Collection'

module MtgTracker
  class CollectionsController < Application

    # Retrieve all collections
    get '/' do
      items = Collection.all
      respond_with collections: items
    end

    # Create a new collection
    post '/' do
      collection = Collection.create!({ name: payload[:name] })
      respond_with collection
    end

    # Retrieve specific collection
    get '/:id' do
      unless params[:id].numeric?
        halt_with_400 'Id should be numeric'
      end
      
      item = Collection.find params[:id]
      respond_with item
    end

    # Update specific collection
    put '/:id' do
      collection = Collection.find(params[:id])
      collection = Collection.update(collection.id, payload)
      respond_with collection

    end

    # Delete specific collection
    delete '/:id' do
      collection = Collection.find(params[:id])
      collection.destroy
      respond_with collection
    end
  end
end
