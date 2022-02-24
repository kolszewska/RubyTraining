require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:karolina)
  end

  test "profile page" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_match @user.feedbacks.count.to_s, response.body
    assert_select 'div.pagination'
    @user.feedbacks.paginate(page: 1).each do |feedback|
      assert_match feedback.content, response.body
    end
  end
end