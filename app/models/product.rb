class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :cart_items
  has_many :order_items

  has_one_attached :image do |attachable|
    attachable.variant(:show, resize_to_limit: [1000, 1000])
  end

  validates :name, presence: true
  validates :description, presence: true
  validates :category_ids, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
  validates :price, presence: true
  validates :stock, presence: true
end
