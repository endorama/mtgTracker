
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

require_relative 'lib/mtg_tracker'

# Set correct database configuration
ActiveRecord::Tasks::DatabaseTasks.database_configuration = YAML.load_file("config/database.yml")

# Annotate gem task
namespace :annotate do
  desc "Annotate your models"
  task :models do |t, args|
    exec "annotate  --model-dir ./models --position after"
  end
end

namespace :app do
  desc "Serve application"
  # http://viget.com/extend/protip-passing-parameters-to-your-rake-tasks
  task :run, [:env] do |t, args|
    env = args[:env] || 'development'

    puts "Running in #{env} mode"

    case env
    when 'development'
      exec "bundle exec rerun --clear -- rackup -E #{env} -p 4567"
    when 'production'
      exec "bundle exec thin start -R config.ru -e $RACK_ENV -p $PORT"
    end


  end
end

desc "Show available application routes"
task :routes do
  require_relative './lib/mtg_tracker.rb'
  endpoints = {}

  if Sinatra::Application.descendants.any?
    #Classic application structure
    applications = Sinatra::Application.descendants
    applications.each do |app|
      endpoints[app.to_s.to_sym] = app.routes
    end
  elsif Sinatra::Base.descendants.any?
    #Modular application structure
    applications = Sinatra::Base.descendants
    applications.each do |app|
      endpoints[app.to_s.to_sym] = app.routes
    end
  else
    abort("Cannot find any defined routes.....")
  end

  endpoints.each do |app_name,routes|
    if app_name.to_s.include? 'Controller'
      name = '/' + app_name.to_s.split('::')[1].gsub('Controller', '').downcase
    else
      name = ''
    end

    routes.each do |verb,handlers|
      next if verb == 'HEAD'

      vl = verb.length
      diff = 'DELETE'.length - vl
      verb_normalized = "#{verb}#{' '*diff}"

      handlers.each do |handler|
        handler_normalized = handler[0].source.gsub('\A', '').gsub('\z', '')
        whites = ' '*(50-name.length-handler_normalized.length)
        puts "#{verb_normalized} #{name}#{handler_normalized} #{whites}(#{app_name})"
      end
    end
  end
end
