class Post < ApplicationRecord
  belongs_to :user
  validates :image, presence: true
  has_one_attached :image, dependent: :destroy
  has_many :comments, dependent: :destroy
end
