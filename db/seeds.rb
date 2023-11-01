5.times do
  Category.create(name: Faker::Commerce.department, description: Faker::Lorem.sentence(word_count: 5))
end
