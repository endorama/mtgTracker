# -*- encoding: utf-8 -*-

class CreateCollections < ActiveRecord::Migration
  def change

    create_table :collections do |t|
      t.string :name
      t.float :value_min
      t.float :value_avg
      t.float :value_max
      t.timestamps
    end

    add_index :collections, [ :name ]

  end
end
