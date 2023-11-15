class Product < ApplicationRecord
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :cart_items, dependent: :nullify
  has_many :order_items, dependent: :nullify

  has_one_attached :image do |attachable|
    attachable.variant(:show, resize_to_limit: [1000, 1000])
  end
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :category_ids, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
  validates :price, presence: true, numericality: true
  validates :stock, presence: true, numericality: true
end
