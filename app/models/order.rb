class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :user
  after_save :clear_cart_total

  def clear_cart_total
    cart = Cart.find_by(id: user_id)
    cart.update(total: 0)
  end
end
