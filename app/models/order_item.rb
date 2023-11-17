class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  after_create :update_stock

  has_one_attached :image

  private

  def update_stock
    product = Product.find(product_id)
    product.update(stock: product.stock - quantity)
  end
end
