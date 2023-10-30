class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table(:products) do |t|
      t.string(:name)
      t.text(:description)
      t.references(:category, null: false, foreign_key: true)
      t.string(:author)
      t.string(:publisher)
      t.float(:price)
      t.integer(:stock)

      t.timestamps
    end
  end
end
