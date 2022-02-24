require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feedback = feedbacks(:project1)
  end

  test "should redirect create when user not logged in" do
    assert_no_difference 'Feedback.count' do
      post feedbacks_path, params: { feedback: { content: "Lorem Ipsum"} }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when user not logged in" do
    assert_no_difference 'Feedback.count' do
      delete feedback_path(@feedback)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy if wrong user" do
    log_in_as(users(:karolina))
    feedback = feedbacks(:project13)
    assert_no_difference 'Feedback.count' do
      delete feedback_path(feedback)
    end
    assert_redirected_to root_url
  end
end
