class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table(:orders) do |t|
      t.references(:user, null: true, foreign_key: true)
      t.integer(:total)
      t.integer(:confirmation)

      t.timestamps
    end
  end
end
