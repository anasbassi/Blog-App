class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  after_create :likes_counter

  def likes_counter
    post.increment!(:likes_counter)
  end
end
