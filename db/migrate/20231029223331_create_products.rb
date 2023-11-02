class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table(:products) do |t|
      t.string(:name)
      t.text(:description)
      t.string(:author)
      t.string(:publisher)
      t.integer(:price)
      t.integer(:stock)

      t.timestamps
    end
  end
end
