class Init < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.timestamps
    end
    create_table :likes do |t|
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
    drop_table :likes
  end

end
