require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:karolina)
  end

  test "should get new" do
    get login_path
    assert_response :success
  end

  test 'should do friendly forwarding' do
    log_in_as(@user)
    assert_redirected_to user_url(@user)
  end
end
