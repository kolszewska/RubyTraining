class FeedbacksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @feedback = current_user.feedbacks.build(feedback_params)
    if @feedback.save
      flash[:success] = "Feedback created"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'html_pages/home'
    end
  end


  def destroy
    @feedback.destroy
    flash[:success] = "Feedback has been deleted"
    redirect_to request.referrer || root_url
  end

  private

  def feedback_params
    params.require(:feedback).permit(:content)
  end

  def correct_user
    @feedback =  current_user.feedbacks.find_by(id: params[:id])
    redirect_to root_url if @feedback.nil?
  end

end
