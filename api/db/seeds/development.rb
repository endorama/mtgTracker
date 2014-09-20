# -*- encoding: utf-8 -*-

require 'active_record'

require_relative '../../scripts/helper'
require_relative '../../lib/mtg_tracker'

# env = ENV['MTGTRACKER_ENV'] || 'development'

logger = Logger.new(STDOUT)
logger.level = Logger::INFO

establish_db_connection logger

lea_set = nil
 
logger.info 'Importing Sets...'
sets = YAML.load_file("#{File.dirname(__FILE__)}/../fixtures/LEA-set.yml")
sets.each do |set|
  tmp_set = {
    name: set[:name],
    code: set[:code],
    release_date: set[:releaseDate]
  }
  lea_set = MtgTracker::Set.create! tmp_set
  logger.debug set[:name]
end

logger.info 'Importing Cards...'
cards = YAML.load_file("#{File.dirname(__FILE__)}/../fixtures/LEA-cards.yml")
cards.each do |card|
  if card[:foreignNames]
    foreignName = card[:foreignNames].select { |a| a[:language] == 'Italian' }
    if foreignName.length > 0
      italian_name = foreignName[0][:name]
    end
  end

  new_card = {
    name: card[:name],
    name_it: italian_name,
    number: card[:number],
    image_name: card[:imageName],
    rarity: card[:rarity],
    multiverse_id: card[:multiverseid]
  }

  set = MtgTracker::Set.find_by code: 'LEA'

  search = set.cards.named card[:name]

  unless search.empty?
    old_card = search.select { |c| c.multiverse_id == new_card[:multiverse_id] }.first
    
    if old_card && old_card != new_card
      logger.warn "This card exists, updating #{old_card.name} (#{old_card.multiverse_id})"
      # update old card
      card = old_card.update_attributes new_card
    else
      card = set.cards.create new_card
    end
  else
    # crete new card linked to set
    card = set.cards.create new_card
  end

  logger.debug "#{card.id} => #{card[:name]}"
end

logger.info 'Creating Collections...'
coll1 = MtgTracker::Collection.create! name: "Foo Collection"
coll1.cards << MtgTracker::Card.find(1)
coll1.cards << MtgTracker::Card.find(1)
coll1.cards << MtgTracker::Card.find(2)
coll1.cards << MtgTracker::Card.find(2)
coll1.cards << MtgTracker::Card.find(3)
coll1.cards << MtgTracker::Card.find(3)

coll2 = MtgTracker::Collection.create! name: "Bar Collection"
coll2.cards << MtgTracker::Card.find(40)
coll2.cards << MtgTracker::Card.find(1)
coll2.cards << MtgTracker::Card.find(10)
coll2.cards << MtgTracker::Card.find(14)
coll2.cards << MtgTracker::Card.find(113)

MtgTracker::Collection.create! name: "FooBar Collection"

logger.info "Development Seed complete"
