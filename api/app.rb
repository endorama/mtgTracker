
require 'sinatra'
require 'sinatra/activerecord'
require 'json'

require_relative 'lib/mtg_tracker'

not_found do
  content_type :json
  halt 404, { error: 'URL not found' }.to_json
end

get '/' do
  content_type :json
  { error: nil, message: 'Hello World!' }.to_json
end
