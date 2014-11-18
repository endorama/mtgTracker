# -*- encoding: utf-8 -*-

class CreateCards < ActiveRecord::Migration
  def change

    create_table :cards do |t|
      t.string :name
      t.string :name_it
      t.string :number
      t.belongs_to :set
      t.string :image_name
      t.integer :rarity, default: 0
      t.integer :multiverse_id
      t.timestamps
    end

    add_index :cards, [ :set_id ]
    add_index :cards, [ :name, :set_id ], unique: true

  end
end
