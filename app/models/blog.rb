class Blog < ApplicationRecord
  validates :content, presence: true, length: { in: 1..140 }
  belongs_to :user
  mount_uploader :image, ImageUploader
  has_many :favorites, dependent: :destroy
end
