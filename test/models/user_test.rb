require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should return the user" do
    user = users(:admin)
    assert_equal user, User.find(user.id)
  end
end
