class AddIndexToFeedbackOnUserIdCreatedAt < ActiveRecord::Migration[6.0]
  def change
    add_index :feedbacks, %i[user_id created_at]
  end
end
