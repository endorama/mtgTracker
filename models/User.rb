# -*- encoding: utf-8 -*-

require 'bcrypt'

module MtgTracker
  class User < ActiveRecord::Base
    attr_accessor :password
    before_save :encrypt_password

    validates :email,
      presence: true,
      uniqueness: true,
      format: {
        with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
        message: "should be a valid email address"
      }
    validates :password,
      presence: true,
      on: :create,
      length: { minimum: 6 }

    has_many :collections,
      dependent: :destroy


    def self.authenticate(email, password)
      user = find_by_email(email)
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      else
        nil
      end
    end

    def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end

    def serializable_hash(options = {})
      options = options.try(:clone) || {}

      options[:except] = [ :password_hash, :password_salt ]

      super(options)
    end

  end
end
