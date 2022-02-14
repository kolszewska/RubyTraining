class AddUserReferenceToFeedback < ActiveRecord::Migration[6.0]
  def change
    remove_column :feedbacks, :user_id
    add_reference :feedbacks, :user, foreign_key: true, null: false
  end
end
