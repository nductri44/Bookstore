class AddNameToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :name, :string
  end
end
