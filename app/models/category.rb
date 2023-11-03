class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 140 }

  def self.products_in_category(category_name)
    category = find_by(name: category_name)
    if category
      category.products
    else
      nil
    end
  end
end
