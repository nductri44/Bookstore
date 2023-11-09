class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true
end
