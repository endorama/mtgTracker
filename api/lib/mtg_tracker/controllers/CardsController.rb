# -*- encoding: utf-8 -*-

require_relative './BaseController'
require_relative '../models/Card'

module MtgTracker
  class CardsController < BaseController

    before do
      authorize!
    end

    # Retrieve specific collection
    get '/:id' do
      unless params[:id].numeric?
        halt_with_400 'Id should be numeric'
      end
      
      item = Card.find params[:id]
      respond_with item
    end

  end
end
