class AddActivationToAdminShops < ActiveRecord::Migration[7.0]
  def change
    add_column(:admin_shops, :activation_digest, :string)
    add_column(:admin_shops, :activated, :boolean, default: false)
    add_column(:admin_shops, :activated_at, :datetime)
  end
end
