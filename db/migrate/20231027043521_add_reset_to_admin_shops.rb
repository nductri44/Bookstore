class AddResetToAdminShops < ActiveRecord::Migration[7.0]
  def change
    add_column(:admin_shops, :reset_digest, :string)
    add_column(:admin_shops, :reset_sent_at, :datetime)
  end
end
