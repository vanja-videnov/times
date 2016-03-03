class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :with_comments, -> (post_id) { includes(:comments).where(id: post_id).first }
  validates :title, presence: true, length: 6..15
end
