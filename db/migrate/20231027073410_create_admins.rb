class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.text :address
      t.string :phone
      t.string :tax_code

      t.timestamps
    end
  end
end
