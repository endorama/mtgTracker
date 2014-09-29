# -*- encoding: utf-8 -*-

require_relative './BaseController'
require_relative '../models/Collection'

module MtgTracker
  class CollectionsController < BaseController

    # Retrieve all collections
    get '/' do
      items = Collection.all
      respond_with items
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

    # Retrieve collection cards
    get '/:id/cards' do
      collection = Collection.find(params[:id])
      respond_with collection.cards
    end

    # Add a card to the collection
    post '/:id/cards' do
      card = Card.find(payload[:id])
      Collection.find(params[:id]).cards.push(card)

      # we need to refetch the collection
      collection = Collection.find(params[:id])
      respond_with collection.cards
    end

    # Delete a card from the collection
    delete '/:id/cards' do 
      card = Card.find(payload[:id])
      Collection.find(params[:id]).cards.delete(card)

      # we need to refetch the collection
      collection = Collection.find(params[:id])
      respond_with cards: collection.cards
    end

  end
end
