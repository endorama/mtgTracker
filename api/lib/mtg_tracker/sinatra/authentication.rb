require "sinatra/base"
require 'jwt'
 
=begin
  
  Handles user session with JSON Web Tokens

  Methods:
    - authorized?       : check if session data are present
    - authorize!        : request authentication to proceed
    - auth_token_data   : in case you need to access the data saved in the token
    - respond_with_token: easy way to return a compliant JWT token, passing
      as param only the data you want to carry

  Settings:
    :jwt_secret: secret key to use to encrypt your JWT token
    :jwt_expire: expiration time of the token ( default 7 days )

  By default on each request it set a variable ( @current_user ) to
    - the user object if a session is present
    - nil if no session is present

  The user object is retrieved calling the block passed to retrieve_user 
  function, so remember to call it.
  Example:
      retrieve_user do |data_sent_with_respond_with_token|
        # User.find data_sent_with_respond_with_token
      end

  If a user is authenticated, store it's data ( retrieved from db using 
  retrieve_user ) in a variable @current_user
  
=end

module Sinatra
  module Authentication
    @@retrieve_user_func = nil

    module Helpers
      @@token = nil
      
      def authorized?
        # get auth header
        auth_header = request.env['HTTP_AUTHORIZATION']
        # not authorized if not present
        return false unless auth_header
        # retrieve JWT token
        auth_header = auth_header.split(' ')[1]
        # decode it
        token = JWT.decode(auth_header, settings.jwt_secret)[0]
        # if we don't have a token raise an error
        raise JWTTokenNotPresent unless token
        # if the token has expired do not authorize
        return false if token['exp'] && Time.now >= token['exp']
        # everything should be ok now :)
        @@token = token
        true
      end

      def authorize!
        halt 401 unless request.options? or authorized?
      end

      def auth_token_data
        @@token['sub']
      end

      def respond_with_token(data)
        payload = Hash.new
        payload[:iss] = request.url
        payload[:sub] = data
        payload[:iat] = Time.now
        payload[:exp] = Time.now + settings.jwt_expire

        respond_with token: JWT.encode(payload, settings.jwt_secret)
      end
    end
 
    def self.registered(app)
      app.helpers Authentication::Helpers

      app.set :jwt_secret, "SomeReallySecretString"
      app.set :jwt_expire, 7.days

      # set @current_user if a session is present
      app.before do
        next if request.options?
        if authorized?
          @current_user = @@retrieve_user_func.call(auth_token_data)
        else
          @current_user = nil
        end
      end
     
    end

    def retrieve_user(&block)
      @@retrieve_user_func = block
    end

  end

  register Authentication
  Delegator.delegate :retrieve_user
end
