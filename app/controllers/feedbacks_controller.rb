class FeedbacksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @feedback = current_user.feedbacks.build(feedback_params)
    if @feedback.save
      flash[:success] = "Feedback created"
      redirect_to root_url
    else
      render 'html_pages/home'
    end
  end


  def destroy
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to feedbacks_url, notice: "Feedback was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def feedback_params
      params.require(:feedback).permit(:content, :user_id)
    end
end
