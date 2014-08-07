require 'active_record'

require_relative '../models'

module MtgTracker
  class Set < ActiveRecord::Base
    has_many :cards,
      dependent: :destroy
    
    validates :code, :name, :release_date, presence: true
    validates :code, :name, uniqueness: true
  end
end
