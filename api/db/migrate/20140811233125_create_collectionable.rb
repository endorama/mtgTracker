# -*- encoding: utf-8 -*-

class CreateCollectionable < ActiveRecord::Migration
  def change

     create_table :collectionables do |t|
      t.belongs_to :card
      t.belongs_to :collection
 
      t.timestamps
    end

    add_index :collectionables, [ :card_id ]
    add_index :collectionables, [ :collection_id ]

  end
end
