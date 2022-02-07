require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:karolina)
    @other_user = users(:jane)
  end

  test 'should get new' do
    get signup_path
    assert_response :success
  end

  test 'should get index' do
    log_in_as(@user)
    get users_path
    assert_response :success
  end

  test 'should redirect index to login when not logged in' do
    get users_path
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url, params: { user: { email: 'test@test.com', name: 'Test', password: 'password1234', password_confirmation: 'password1234' } }
    end

    assert_redirected_to user_url(User.last)
  end

  test 'should show user' do
    get user_url(@user)
    assert_response :success
  end

  test 'should get edit' do
    log_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test 'should update user' do
    log_in_as(@user)
    patch user_url(@user), params: { user: { email: @user.email, job_role: @user.job_role, name: @user.name } }
    assert_redirected_to user_url(@user)
  end

  test 'should delete user' do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
  end

  test 'should redirect edit to login when not logged in' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test 'should redirect update to login when not logged in' do
    patch user_url(@user), params: { user: { email: @user.email, job_role: @user.job_role, name: @user.name } }
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    delete user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect destroy when not admin" do
    log_in_as(@other_user)
    delete user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end
end
