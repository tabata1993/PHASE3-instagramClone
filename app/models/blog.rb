class Blog < ApplicationRecord
  mount_uploader :image, BlogImageUploader

  belongs_to :user
  has_many :favorites,dependent: :destroy
  has_many :favorite_users,through: :faorites, source: :user

  validates :image , presence: true
  validates :title ,length: {in: 1..30}
  validates :content ,length: {in: 1..140}
end
