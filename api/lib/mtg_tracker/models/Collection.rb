# -*- encoding: utf-8 -*-

require 'active_record'

module MtgTracker
  class Collection < ActiveRecord::Base
    has_and_belongs_to_many :cards
    
    validates :name,
      presence: true,
      uniqueness: true
  end
end
