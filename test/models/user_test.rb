require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Test User', email: 'test@example.com')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'name cannot be too long' do
    @user.name = 'a' * 61
    assert_not @user.valid?
  end

  test 'email cannot be too long' do
    @user.email = "#{'a' * 255}@example.com"
    assert_not @user.valid?
  end

  valid_addresses = %w[example@example.com EXAMPLE@example.com EXAMPLE-01@example.com first.last@example.com first+last@example.com]
  valid_addresses.each do |valid_address|
    test "#{valid_address} should be accepted as valid email" do
      @user.email = valid_address
      assert @user.valid?
    end
  end

  invalid_addresses = %w[example.com 123 @example.com first.last@@example.com]
  invalid_addresses.each do |invalid_address|
    test "#{invalid_address} should not be accepted as valid email" do
      @user.email = invalid_address
      assert_not @user.valid?
    end
  end

  test 'email address should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

end
