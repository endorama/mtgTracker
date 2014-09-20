require 'active_record'

module MtgTracker
  class Card < ActiveRecord::Base
    belongs_to :set
    has_many :collectionables
    has_many :collections, through: :collectionables
    
    validates :name, :set_id, :image_name, :rarity, :multiverse_id,
      presence: true
    validates :name, uniqueness: {
      scope: :set_id,
      message: "Only one card of the same name for MtgSet"
    }

    enum rarity: [ :mythic, :rare, :uncommon, :common, :special, :land ]

    scope :named, lambda { |name| where "name = ? OR name_it = ?", name, name }

    def rarity=(rarity)
      rarity = 'mythic' if rarity == 'Mythic Rare'
      rarity = 'land' if rarity == 'Basic Land'
      
      write_attribute(:rarity, rarity)
    end

    def serializable_hash(options = {})
      options = options.try(:clone) || {}

      options[:except] = [ :created_at, :updated_at ]
      options[:include] = :set

      super(options)
    end

  end
end
