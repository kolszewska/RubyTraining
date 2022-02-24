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

  test "should create feedback" do
    assert_difference('Feedback.count') do
      post feedbacks_url, params: { feedback: { content: @feedback.content, user_id: @feedback.user_id } }
    end

    assert_redirected_to feedback_url(Feedback.last)
  end

  test "should destroy feedback" do
    assert_difference('Feedback.count', -1) do
      delete feedback_url(@feedback)
    end

    assert_redirected_to feedbacks_url
  end
end
