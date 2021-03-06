require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:karolina)
  end

  test 'login with invalid information' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: ""}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid information' do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password123'} }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test 'login with valid information and then logout' do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password123'} }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
  end

end
