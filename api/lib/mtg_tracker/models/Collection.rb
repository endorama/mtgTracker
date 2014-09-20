# -*- encoding: utf-8 -*-

require 'active_record'

module MtgTracker
  class Collection < ActiveRecord::Base
    has_many :collectionables,
      dependent: :destroy

    has_many :cards, 
      through: :collectionables
      

    validates :name,
      presence: true,
      uniqueness: true

    # def serializable_hash(options = {})
    #   options = options.try(:clone) || {}
    #   # This will lead to A LOT of data...
    #   # a cool idea could be to limit the query and add pagination
    #   options[:include] = :cards

    #   super(options)
    # end
  end
end
