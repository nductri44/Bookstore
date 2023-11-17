5.times do
  Category.create(name: Faker::Book.genre, description: Faker::Lorem.sentence(word_count: 5))
end

categories = Category.all
10.times do |n|
  product = Product.create(
    name: Faker::Sports::Football.player,
    description: Faker::Lorem.sentence(word_count: 30),
    author: Faker::Book.author,
    publisher: Faker::Book.publisher,
    price: Faker::Number.between(from: 80_000, to: 400_000),
    stock: Faker::Number.between(from: 1, to: 100)
  )
  image = File.open(Rails.root.join("app/assets/images/book_#{n + 1}.jpg"))
  product.image.attach(io: image, filename: "book_#{n + 1}.jpg")
  product.categories << categories.sample(rand(1..5))
  product.save!
end
