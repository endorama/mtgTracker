
require 'active_record'
require 'sqlite3'

# Put this in a seed file?

require 'logger'

require_relative './helper'
require_relative '../lib/mtg_tracker/models'

SET_LIST_FILE = 'storage/SetList.json'
SET_LIST_URL = 'http://mtgjson.com/json/SetList.json'
logger = Logger.new(STDOUT)
logger.level = Logger::INFO

# - ActiveRecord configs -
ActiveRecord::Base.logger = logger
ActiveRecord::Base.configurations = YAML::load(IO.read('config/database.yml'))
ActiveRecord::Base.establish_connection(:development)

# - script execution -

# if set list file is older than 6 days download it again
if file_age(SET_LIST_FILE) > 6
  logger.info "Downloading #{SET_LIST_URL} into #{SET_LIST_FILE}"
  begin
    download(SET_LIST_URL, SET_LIST_FILE)
  rescue
    logger.error "Internet connection not available"
  end
end

# parse json
setList = parse_json(SET_LIST_FILE)

# save data into db
setList.each do |set|
  logger.info set
  MtgTracker::Set.create name: set[:name], code: set[:code], release_date: set[:releaseDate]
end

