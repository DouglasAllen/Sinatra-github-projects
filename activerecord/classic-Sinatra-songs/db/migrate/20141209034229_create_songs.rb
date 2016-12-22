class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |table|
      table.string :title, null: false
      table.string :album, null: false
      table.string :artist, null: false
      table.integer :year, null: false
      table.timestamps
    end
  end
end
