# -*- encoding: utf-8 -*-

require 'active_record'

require_relative 'lib/core_ext/string'
require_relative 'lib/mtg_tracker/version'
require_relative 'lib/mtg_tracker/application'

# Dinamic require all models
Dir.glob('./models/*.rb').each { |file| require "#{file}" }

# Dinamic require all controllers
Dir.glob('./controllers/*.rb').each { |file| require "#{file}" }

# Run Sinatra application
run MtgTracker::Application

# For each controller map it to the specified route based on name
Dir.glob('./controllers/*.rb').each { |file|

  # skip setting route for BaseController
  next if file =~ /BaseController/

  # puts "#{file}"
  controller = File.basename(file).split('.')[0]
  # puts "#{controller}"
  controller_path = File.basename(file).underscore.split('_')[0]
  # puts "#{controller_path}"

  map("/#{controller_path}") { run "MtgTracker::#{controller}".constantize }
}
