class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: 6..15
  validates :body, presence: true, length: 10..150

  scope :with_comments, -> (post_id) { includes(:comments).where(id: post_id).first }

  def self.with_comments_alt(post_id)
    includes(:comments).where(id: post_id).first
  end
end
