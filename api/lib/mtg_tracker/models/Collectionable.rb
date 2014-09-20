# -*- encoding: utf-8 -*-

require 'active_record'

module MtgTracker
  class Collectionable < ActiveRecord::Base
    belongs_to :collection
    belongs_to :card
  end
end
