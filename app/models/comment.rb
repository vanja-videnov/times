class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :body, length: { in: 5..60 }, presence: true
  #validates :post_id, presence: true

  scope :for_post, -> (post_id) { where(post_id: post_id) }

  def self.for_user(user_id)
    where(user_id: user_id).references(:comments)
  end

  def owner
    User.find_by(id: self.user_id)
  end
end
