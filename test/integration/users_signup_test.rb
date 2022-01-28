require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '', email: 'test@example', password: 'pass', password_confirmation: 'word' } }
    end
    assert_template 'users/new'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Test', email: 'test@example.com', password: 'pass123', password_confirmation: 'pass123' } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
