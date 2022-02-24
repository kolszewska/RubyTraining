require 'test_helper'

class FeedbackInterfaceTest < ActionDispatch::IntegrationTest
  def after_setup
    @user = users(:karolina)
  end

  test "test invalid submission does not add new feedback" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'

    assert_no_difference 'Feedback.count' do
      post feedbacks_url, params: { feedback: { content: "" } }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'
  end

  test "valid submission adds new feedback" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'

    content = 'Very good job!'
    assert_difference 'Feedback.count', 1 do
      post feedbacks_url, params: { feedback: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
  end

  test "delete feedback" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'

    assert_select 'a', text: 'delete'
    first_feedback = @user.feedbacks.paginate(page: 1).first
    assert_difference 'Feedback.count', -1 do
      delete feedback_path(first_feedback)
    end
  end

  test 'does not show delete link if logged in as different user' do
    log_in_as(@user)
    get user_path(users(:jane))
    assert_select 'a', text: 'delete', count: 0
  end
end
