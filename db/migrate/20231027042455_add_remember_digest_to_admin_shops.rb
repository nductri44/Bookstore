class AddRememberDigestToAdminShops < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_shops, :remember_digest, :string
  end
end
