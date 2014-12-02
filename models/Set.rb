# -*- encoding: utf-8 -*-

module MtgTracker
  class Set < ActiveRecord::Base
    has_many :cards,
      dependent: :destroy

    validates :code, :name, :release_date, presence: true
    validates :code, :name, uniqueness: true

    def serializable_hash(options = {})
      options = options.try(:clone) || {}

      options[:except] = [ :created_at, :updated_at ]

      super(options)
    end
  end
end
