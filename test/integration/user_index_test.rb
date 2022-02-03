require 'test_helper'

class UserIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:karolina)
  end

  test "index" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
end
