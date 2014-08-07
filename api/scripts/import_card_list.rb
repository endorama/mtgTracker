
# Put this in a seed file

require 'active_record'
require 'sqlite3'
require 'logger'

require_relative './helper'
require_relative '../lib/mtg_tracker/models'

CARD_LIST_FILE = 'storage/AllSets-x.json'
CARD_LIST_URL = 'http://mtgjson.com/json/AllSets-x.json.zip'
logger = Logger.new(STDOUT)
logger.level = Logger::INFO

# - ActiveRecord configs -
ActiveRecord::Base.logger = logger
ActiveRecord::Base.configurations = YAML::load(IO.read('config/database.yml'))
ActiveRecord::Base.establish_connection(:development)

# - script execution -

# if set list file is older than 6 days download it again
if file_age(CARD_LIST_FILE) > 6
  logger.info "Downloading #{CARD_LIST_URL} into #{CARD_LIST_FILE}"
  begin
    download_and_extract(CARD_LIST_URL, CARD_LIST_FILE)
  rescue
    logger.error "Internet connection not available"
  end
end

# parse json
sets = parse_json(CARD_LIST_FILE)

# save data into db
set_total = sets.length
card_total = 0
sets.each_with_index do |set, set_idx|
  # sets is an hash, so the set object is an array with [key, value]
  set = set[1]

  set_card_total = set[:cards].length
  card_total += set_card_total

  set[:cards].each_with_index do |card, card_idx|
    logger.info "Set #{set[:code]} #{set_idx+1}/#{set_total} | Card #{card_idx+1}/#{set_card_total}"

    logger.debug card

    if card[:foreignNames]
      foreignName = card[:foreignNames].select { |a| a[:language] == 'Italian' }
      if foreignName.length > 0
        italian_name = foreignName[0][:name]
      end
    end

    # create hash of the new card, to be used on creation
    new_card = {
      name: card[:name],
      name_it: italian_name,
      number: card[:number],
      image_name: card[:imageName],
      rarity: card[:rarity],
      multiverse_id: card[:multiverseid]
    }

    # get current set
    mtgSet = MtgTracker::Set.find_by code: set[:code]

    # search card in set
    search = mtgSet.cards.named card[:name]

    # puts search.inspect
    # puts search.size  unless search.empty?
    # puts search.count  unless search.empty?
    # # puts search.kind_of(Array) unless search.empty?
    # puts search.select { |c| c.multiverse_id == new_card[:multiverse_id] }.inspect unless search.empty?

    unless search.empty?
      old_card = search.select { |c| c.multiverse_id == new_card[:multiverse_id] }.first

      # puts search.inspect
      # puts mtgSet.inspect
      # puts old_card.inspect
      # puts new_card.inspect
      # puts old_card != new_card

      if old_card && old_card != new_card
        logger.warn "This card exists, updating #{old_card.name} (#{old_card.multiverse_id})"
        # update old card
        old_card.update_attributes new_card
      else
        mtgSet.cards.create new_card
      end
    else
      # crete new card linked to set
      mtgSet.cards.create new_card
    end
  end
end

logger.info "Imported #{card_total} in #{set_total} sets"
