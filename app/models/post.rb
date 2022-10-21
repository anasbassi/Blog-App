class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :post_counter

  def recent_comments
    Comment.limit(5).order(created_at: :desc)
  end

  private

  def post_counter
    user.increment!(:PostsCounter)
  end
end
