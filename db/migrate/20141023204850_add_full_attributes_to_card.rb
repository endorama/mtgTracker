class AddFullAttributesToCard < ActiveRecord::Migration
  def change

    add_column :cards, :manaCost,   :string
    add_column :cards, :cmc,        :integer
    add_column :cards, :colors,     :text
    add_column :cards, :type,       :string
    add_column :cards, :supertypes, :text
    add_column :cards, :types,      :text
    add_column :cards, :subtypes,   :text
    add_column :cards, :text,       :text
    add_column :cards, :power,      :integer
    add_column :cards, :toughness,  :integer

  end
end
