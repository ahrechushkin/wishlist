class Wishlist < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true

  belongs_to :user
  has_many :wishlist_items
end