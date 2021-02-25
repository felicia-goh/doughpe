User.destroy_all
Product.destroy_all
Order.destroy_all
Slot.destroy_all

5.times do
  baker = User.create!(
    name: Faker::Name.name,
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    password: "123456",
    bio: Faker::Lorem.sentence,
    address: Faker::Address.full_address,
    baker: true
  )
  baker_photo = URI.open('https://source.unsplash.com/random/400x400')
  baker.photo.attach(io: baker_photo, filename: "#{baker.username}.png", content_type: 'image/png')

  product = Product.create!(
    name: "#{Faker::Dessert.flavor} #{Faker::Dessert.variety}",
    price: rand * (5..10).to_a.sample,
    description: Faker::Lorem.sentence,
    user: baker
    )
  product_photo = URI.open('https://source.unsplash.com/400x400/?bake')
  product.photo.attach(io: product_photo, filename: "#{product.name}.png", content_type: 'image/png')
end

5.times do
  user = User.create!(
    name: Faker::Name.name,
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    password: "123456",
    address: Faker::Address.full_address,
    baker: false
  )
  user_photo = URI.open('https://source.unsplash.com/random/400x400')
  user.photo.attach(io: user_photo, filename: "#{user.username}.png", content_type: 'image/png')
end
baker1 = User.create!(
    name: Faker::Name.name,
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    password: "123456",
    bio: Faker::Lorem.sentence,
    address: Faker::Address.full_address,
    baker: true
  )
  baker_photo = open('https://source.unsplash.com/random/400x400')
  baker1.photo.attach(io: baker_photo, filename: "#{baker1.username}.png", content_type: 'image/png')
 product1 = Product.create!(
    name: "#{Faker::Dessert.flavor} #{Faker::Dessert.variety}",
    price: rand * (5..10).to_a.sample,
    description: Faker::Lorem.sentence,
    user: baker1
    )
  product_photo = open('https://source.unsplash.com/400x400/?bake')
  product1.photo.attach(io: product_photo, filename: "#{product1.name}.png", content_type: 'image/png')

slot1 = Slot.create!(
    date: Date.today,
    available_quantity: (1..10).to_a.sample,
    product: Product.first
)
user1 = User.create!(
    name: Faker::Name.name,
    username: Faker::Internet.username,
    email: Faker::Internet.email,
    password: "123456",
    bio: Faker::Lorem.sentence,
    address: Faker::Address.full_address,
    baker: false
)
  user_photo = open('https://source.unsplash.com/random/400x400')
  user1.photo.attach(io: user_photo, filename: "#{user1.username}.png", content_type: 'image/png')
Order.create!(
  user: User.first,
  delivery_method: 'delivery',
  delivery_address: User.first.address,
  slot: Slot.create!(available_quantity: (1..10).to_a.sample),
  status: nil,
  total: Product.first.price,
  quantity: 1
)
user_photo = open('https://source.unsplash.com/random/400x400')
user.photo.attach(io: user_photo, filename: "#{user1.username}.png", content_type: 'image/png')


