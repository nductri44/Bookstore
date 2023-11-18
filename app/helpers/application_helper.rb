module ApplicationHelper
  def current_quantity(product)
    return unless current_user.cart.cart_items.find_by(product_id: product.id).present?

    current_user.cart.cart_items.find_by(product_id: product.id).quantity
  end
end
