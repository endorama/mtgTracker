# -*- encoding: utf-8 -*-

module MtgTracker
  class Collectionable < ActiveRecord::Base
    belongs_to :collection
    belongs_to :card
  end
end
