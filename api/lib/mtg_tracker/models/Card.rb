require 'active_record'

require_relative '../models/Set'
require_relative '../models/Collection'

module MtgTracker
  class Card < ActiveRecord::Base
    belongs_to :set
    has_and_belongs_to_many :collections
    
    validates :name, :number, :set_id, :image_name, :rarity, :multiverse_id,
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

  end
end
