require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  def setup
    @user = users(:karolina)
    @feedback = @user.feedbacks.build(content:'Very good job')
  end

  test 'should be valid' do
    assert @feedback.valid?
  end

  test 'user should be present' do
    @feedback.user_id = nil
    assert_not @feedback.valid?
  end

  test 'content should be present' do
    @feedback.content = ''
    assert_not @feedback.valid?
  end

  test 'content should be no more than 250 characters' do
    @feedback.content = 'a' * 251
    assert_not @feedback.valid?
  end

  test 'content should be at least 10 characters' do
    @feedback.content = 'a' * 10
    assert @feedback.valid?
  end

  test'most recent feedback should be returned first' do
    assert_equal feedbacks(:most_recent), Feedback.first
  end
end
