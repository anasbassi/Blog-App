class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :comment_counter

  def comment_counter
    post.increment!(:CommentsCounter)
  end
end
