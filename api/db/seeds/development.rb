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

  # enum fields needs to be expressed as integers
  case card[:rarity].downcase
    when 'common'   then card_rarity = 0
    when 'uncommon' then card_rarity = 1
    when 'rare'     then card_rarity = 2
    when 'mythic'   then card_rarity = 3
    when 'special'  then card_rarity = 4
    when 'land'     then card_rarity = 5
  end

  new_card = {
    name: card[:name],
    name_it: italian_name,
    manaCost: card[:manaCost],
    cmc: card[:cmc],
    colors: card[:colors],
    type: card[:type],
    supertypes: card[:supertypes],
    types: card[:types],
    subtypes: card[:subtypes],
    rarity: card_rarity,
    text: card[:text],
    number: card[:number],
    power: card[:power].to_i,
    toughness: card[:toughness].to_i,
    image_name: card[:imageName],
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

logger.info 'Creating Users...'
user1 = MtgTracker::User.create email: 'edoardo.tenani@gmail.com', password: '123456'
user2 = MtgTracker::User.create email: 'asd@asd.com', password: '123123'

logger.info 'Creating Collections...'
# coll1 = MtgTracker::Collection.create! name: "Foo Collection"
coll1 = user2.collections.create name: "Foo Collection"

coll1.cards << MtgTracker::Card.find(1)
coll1.cards << MtgTracker::Card.find(1)
coll1.cards << MtgTracker::Card.find(2)
coll1.cards << MtgTracker::Card.find(2)
coll1.cards << MtgTracker::Card.find(3)
coll1.cards << MtgTracker::Card.find(3)

# coll2 = MtgTracker::Collection.create! name: "Bar Collection"
coll2 = user2.collections.create name: "Bar Collection"
coll2.cards << MtgTracker::Card.find(40)
coll2.cards << MtgTracker::Card.find(1)
coll2.cards << MtgTracker::Card.find(10)
coll2.cards << MtgTracker::Card.find(14)
coll2.cards << MtgTracker::Card.find(113)


user2.collections.create name: "FooBar Collection"

logger.info "Development Seed complete"
