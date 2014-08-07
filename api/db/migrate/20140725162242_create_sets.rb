class CreateSets < ActiveRecord::Migration
  def change

    create_table :sets do |t|
      t.string :code
      t.string :name
      t.date :release_date
      t.timestamps
    end

    add_index :sets, :code

  end
end
