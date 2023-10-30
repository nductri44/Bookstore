class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :subcategories, class_name: 'Category', foreign_key: :parent_category_id, dependent: :destroy
  belongs_to :parent_category, class_name: 'Category', optional: true

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 140 }
end
