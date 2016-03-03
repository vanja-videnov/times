require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def test_too_long_comment
    comment = Comment.new(body: 'This is test body!')
    assert comment.valid?


    marija=users(:marija)
    assert_not marija.comments << comments(:marijin), "Komentar je predugacak"
  end

  def test_empty_comment
    jovan=users(:jovan)
    assert_not jovan.comments << comments(:jovanov), "Komentar je prazan!"
  end

  def test_set_comment_without_post
    jovan=users(:jovan)
    assert_not jovan.comments << comments(:two), "Nema post_id!"
  end
end
