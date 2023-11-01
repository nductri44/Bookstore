class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :cart_items

  has_one_attached :image do |attachable|
    attachable.variant(:thumb, resize_to_limit: [100, 100])
    attachable.variant(:home, resize_to_limit: [300, 300])
  end

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 140 }
  validates :category_ids, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
  validates :price, presence: true
  validates :stock, presence: true
end
