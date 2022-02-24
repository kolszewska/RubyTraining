class Feedback < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, length: { minimum: 10, maximum: 250 }
  validates :image,
            content_type: {
              in: %w[image/jpeg image/gif image/png],
              message: "Please upload valid file type (jpeg, gif, png)."
            },
            size: {
              less_than: 5.megabytes,
              message: "Your image exceeds 5MB."
            }

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
