class AddResetToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column(:admins, :reset_digest, :string)
    add_column(:admins, :reset_sent_at, :datetime)
  end
end
