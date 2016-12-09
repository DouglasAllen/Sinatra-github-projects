class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string  :title
      t.text    :body
      t.boolean :published, default: false
      t.timestamps
    end
    Post.create(title: 'Hello there !', body: 'This is your first post !', published: true)
  end

  def down
    drop_table :posts
  end
end
