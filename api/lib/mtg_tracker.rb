
require_relative 'core_ext/string'

require_relative 'mtg_tracker/version'
# Require all models
Dir.glob('./lib/mtg_tracker/models/*.rb').each { |file| require "#{file}" }
require_relative 'mtg_tracker/application'
# Require all controllers
Dir.glob('./lib/mtg_tracker/controllers/*.rb').each { |file| require "#{file}" }

module MtgTracker
end
