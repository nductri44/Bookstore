5.times do
  Category.create(name: Faker::Book.genre, description: Faker::Lorem.sentence(word_count: 5))
end
