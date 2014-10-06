# -*- encoding: utf-8 -*-

require_relative './BaseController'
require_relative '../models/Collection'

module MtgTracker
  class CollectionsController < BaseController

    before do
      authorize!
    end

    # Retrieve all collections
    get '/' do
      items = @current_user.collections.all
      respond_with items
    end

    # Create a new collection
    post '/' do
      collection = @current_user.collections.create!({ name: payload[:name] })
      respond_with collection
    end

    # Retrieve specific collection
    get '/:id' do
      unless params[:id].numeric?
        halt_with_400 'Id should be numeric'
      end
      
      item = @current_user.collections.find params[:id]
      respond_with item
    end

    # Update specific collection
    put '/:id' do
      collection = @current_user.collections.find(params[:id])
      collection = @current_user.collections.update(collection.id, payload)
      respond_with collection

    end

    # Delete specific collection
    delete '/:id' do
      collection = @current_user.collections.find(params[:id])
      collection.destroy
      respond_with collection
    end

    # Retrieve collection cards
    get '/:id/cards' do
      collection = @current_user.collections.find(params[:id])
      respond_with collection.cards
    end

    # Add a card to the collection
    post '/:id/cards' do
      card = Card.find(payload[:id])
      @current_user.collections.find(params[:id]).cards.push(card)

      # we need to refetch the collection
      collection = @current_user.collections.find(params[:id])
      respond_with collection.cards
    end

    # Delete a card from the collection
    delete '/:id/cards' do 
      card = Card.find(payload[:id])
      @current_user.collections.find(params[:id]).cards.delete(card)

      # we need to refetch the collection
      collection = @current_user.collections.find(params[:id])
      respond_with collection.cards
    end

  end
end
