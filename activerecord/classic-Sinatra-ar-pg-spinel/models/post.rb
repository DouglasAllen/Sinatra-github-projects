class Post < ActiveRecord::Base

  def self.published
    where(published: true)
  end

  def self.get_last(number)
    last(number)
  end

  def published?
    published == true
  end

  def publish!
    self.published = true
    self.save!
  end

  def unpublish!
    self.published = false
    self.save!
  end

end
