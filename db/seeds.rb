5.times do
  Category.create(name: Faker::Book.genre, description: Faker::Lorem.sentence(word_count: 5))
end

categories = Category.all
10.times do |n|
  product = Product.create(
    name: Faker::Book.title,
    description: Faker::Lorem.sentence(word_count: 5),
    author: Faker::Book.author,
    publisher: Faker::Book.publisher,
    price: Faker::Number.between(from: 100, to: 500),
    stock: Faker::Number.between(from: 1, to: 100)
  )
  image = File.open(Rails.root.join("app/assets/images/book#{n + 1}.jpg"))
  product.image.attach(io: image, filename: "book#{n + 1}.jpg")
  product.categories << categories.sample(rand(1..5))
  product.save!
end
