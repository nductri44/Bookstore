class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image do |attachable|
    attachable.variant(:thumb, resize_to_limit: [100, 100])
    attachable.variant(:big, resize_to_limit: [400, 400])
  end

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 140 }
  validates :category_id, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
  validates :price, presence: true
  validates :stock, presence: true
  validates :image,
            content_type: {
              in: %w[image/jpeg image/gif image/png],
              message: 'must be a valid image format'
            },
            size:
            {
              less_than: 5.megabytes,
              message:
            'should be less than 5MB'
            }
end
