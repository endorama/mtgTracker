# -*- encoding: utf-8 -*-

require_relative './BaseController'

module MtgTracker
  class AuthController < BaseController

    get '/user' do
      respond_with @current_user if @current_user
      halt_with_401
    end

    post '/login' do
      # PLEASE SANITIZE #
      email = payload[:email]
      password = payload[:password]

      user = User.authenticate email, password

      if user
        respond_with_token user.id, user
      else
        halt_with_400 'Wrong credentials'
      end
    end

    post '/signup' do
      # Sanitize payload
      user = User.new(payload)
      if user.save
        respond_with_token user.id, user
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
