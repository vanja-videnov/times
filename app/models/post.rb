class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: 6..15
  validates :body, presence: true, length: 10..150

  scope :with_comments_alt, -> (post_id) { includes(:comments).where(id: post_id).first }

  def self.with_comments(post_id)
    includes(:comments).where(id: post_id).first
  end

  def owner
    User.find_by(id: self.user_id)
  end

  def self.is_owner? (user_id, post_id)
    Post.find(post_id).owner.id == user_id
  end
end
