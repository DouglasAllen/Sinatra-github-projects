class Items < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.string :description
      t.timestamps # add created_at, updated_at column
    end
  end

  def self.down
    drop_table :items
  end
end
