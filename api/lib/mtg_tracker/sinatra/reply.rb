require 'sinatra/base'

module Sinatra
  module ReplyHelpers
    @type = :json

    def reply_with data
      content_type @type
      { error: nil, message: nil, data: data }.to_json
    end
    
    def reply_with_error code, error = nil
      content_type @type

      unless error
        case code
          when 400
            error = 'Bad Request'
          when 401
            error = 'Unauthorized'
          when 403
            error = 'Forbidden'
          when 404
            error = 'Not Found'
          when 405
            error = 'Method Not Allowed'
          when 422
            error = 'Unprocessable Entity'
          when 500
            error = 'Internal Server Error'
          when 501
            error = 'Not Implemented'
          else
            error = "Unexpected error code: #{code}"
        end
      end

      halt code, { error: error, message: nil, data: nil }.to_json
    end

    def reply_with_message message
      content_type @type
      { error: nil, message: message, data: nil }.to_json
    end
  end

  helpers ReplyHelpers
end
