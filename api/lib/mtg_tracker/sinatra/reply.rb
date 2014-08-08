require 'sinatra/base'

module Sinatra
  module ReplyHelpers
    @type = :json

    def reply_with data
      content_type @type
      { message: nil, data: data }.to_json
    end
    
    def reply_with_error code, message = nil
      content_type @type

      unless message
        case code
          when 400
            message = 'Bad Request'
          when 401
            message = 'Unauthorized'
          when 403
            message = 'Forbidden'
          when 404
            message = 'Not Found'
          when 405
            message = 'Method Not Allowed'
          when 422
            message = 'Unprocessable Entity'
          when 500
            message = 'Internal Server Error'
          when 501
            message = 'Not Implemented'
          else
            message = "Unexpected error code: #{code}"
        end
      end

      halt code, { message: message, data: nil }.to_json
    end

    def reply_with_message message
      content_type @type
      { message: message, data: nil }.to_json
    end
  end

  helpers ReplyHelpers
end
