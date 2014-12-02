# -*- encoding: utf-8 -*-

env = ENV['MTGTRACKER_ENV'] || 'development'

logger = Logger.new(STDOUT)
logger.level = Logger::INFO

case env
  when 'development'
    # logger.warn 'No actions for development'
    load "#{File.dirname(__FILE__)}/seeds/development.rb"
  when 'production'
    logger.warn 'No actions for production'
  else 
    logger.error 'Unknown MTGTRACKER_ENV value'
end
