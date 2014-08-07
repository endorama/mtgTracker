require 'sinatra/base'

module Sinatra
  module ReplyHelpers
    @type = :json

    def reply_with data
      content_type @type
      { error: nil, message: nil, data: data }.to_json
    end
    
    def reply_with_error error, code = 400
      content_type @type
      halt code, { error: error, message: nil, data: nil }.to_json
    end

    def reply_with_message message
      content_type @type
      { error: nil, message: message, data: nil }.to_json
    end
  end

  helpers ReplyHelpers
end
