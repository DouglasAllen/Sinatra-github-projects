class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |table|
      table.string :name, null: false
      table.timestamps
    end

    add_column :songs, :artist_id, :integer
  end
end
