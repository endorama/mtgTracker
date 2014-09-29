# -*- encoding: utf-8 -*-

require_relative '../application'
require_relative '../models/User'

module MtgTracker
  class AuthController < Application

    post '/login' do
      # PLEASE SANITIZE #
      email = payload[:email]
      password = payload[:password]

      user = User.authenticate email, password

      if user
        respond_with_token user.id
      else
        halt_with_400 'Wrong credentials'
      end
    end

    post '/signup' do
      # Sanitize payload
      user = User.new(payload)
      if user.save
        [204, {}]
      else
        key = user.errors.keys[0]
        message = user.errors.messages[key][0]
        halt_with_400 "#{key.capitalize} #{message}"
      end
    end

    post '/forgot' do
      # send email for forgot password
    end

  end
end
