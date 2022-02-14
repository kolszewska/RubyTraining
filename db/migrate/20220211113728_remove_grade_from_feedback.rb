class RemoveGradeFromFeedback < ActiveRecord::Migration[6.0]
  def change
    remove_column :feedbacks, :grade, :integer
  end
end
