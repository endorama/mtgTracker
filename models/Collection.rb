# -*- encoding: utf-8 -*-

module MtgTracker
  class Collection < ActiveRecord::Base
    has_many :collectionables,
      dependent: :destroy

    has_many :cards,
      # This adds a .quantity property to the card objects
      lambda { select('cards.*, cards.id as "card_id", count(card_id) as "quantity"').group(:card_id) },
      through: :collectionables

    validates :name,
      presence: true,
      uniqueness: true

    def serializable_hash(options = {})
      options = options.try(:clone) || {}

      options[:except] = [ :created_at, :updated_at ]
      # This will lead to A LOT of data...
      # a cool idea could be to limit the query and add pagination
      # options[:include] = :cards

      super(options)
    end
  end
end
