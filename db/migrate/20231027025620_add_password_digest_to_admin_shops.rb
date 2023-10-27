class AddPasswordDigestToAdminShops < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_shops, :password_digest, :string
  end
end
