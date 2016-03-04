class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :body, length: { in: 5..60 }, presence: true
  #validates :post_id, presence: true

  scope :for_post, -> (post_id) { where(post_id: post_id) }
end
