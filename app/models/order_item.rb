class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  after_create :update_stock, :clear_cart_item

  private

  def update_stock
    product = Product.find(product_id)
    product.update(stock: product.stock - quantity)
  end

  def clear_cart_item
    cart_item = CartItem.find_by(product_id:)
    cart_item.destroy
  end
end
