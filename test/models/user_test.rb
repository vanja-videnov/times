require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save user without email/pass" do
    user = User.new
    assert_not user.save, "Saved the user without an email/pass"
  end
  def test_without_password
    user=User.new(email: users(:marija).email)
    assert_not user.save, "Save user without pass"
  end
  def test_bla
    user_test=users(:ivan)
    assert_not user_test.password=="bla", "Wrong"
  end

end
