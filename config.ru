# -*- encoding: utf-8 -*-

require_relative 'lib/mtg_tracker'

# Run Sinatra application
run MtgTracker::Application

# For each controller map it to the specified route based on name
Dir.glob('./lib/mtg_tracker/controllers/*.rb').each { |file|

  # skip setting route for BaseController
  next if file =~ /BaseController/

  # puts "#{file}"
  controller = File.basename(file).split('.')[0]
  # puts "#{controller}"
  controller_path = File.basename(file).underscore.split('_')[0]
  # puts "#{controller_path}"

  map("/#{controller_path}") { run "MtgTracker::#{controller}".constantize }
}
