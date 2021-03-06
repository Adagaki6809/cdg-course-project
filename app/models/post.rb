# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :image, presence: true
  has_one_attached :image, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def author?(user)
    user == self.user
  end
end
