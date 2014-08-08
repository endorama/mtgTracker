class CreateCardsCollections < ActiveRecord::Migration
  def change

    create_table :cards_collections, :id => false do |t|
      t.integer :card_id
      t.integer :collection_id
    end

    add_index :cards_collections, [ :collection_id ]

  end
end
