
require 'sinatra/base'

module Sinatra
  module RequestHelpers
    
    def request_sanitize data
      data
    end
  end

  helpers RequestHelpers
end
