class User < ApplicationRecord
  has_many :feedbacks
  before_save { self.email = email.downcase}
  validates :name, presence: true, length: { maximum: 60 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true
end
