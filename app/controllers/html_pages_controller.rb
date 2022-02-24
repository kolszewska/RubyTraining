class HtmlPagesController < ApplicationController
  def home
    @feedback = current_user.feedbacks.build if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
