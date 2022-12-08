class WishlistItem < ActiveRecord::Base
  belongs_to :wishlist
  validates :name, presence: true
  validates :description, presence: true

  scope :actual, -> { where(actual: true) }

end