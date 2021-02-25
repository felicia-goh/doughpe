User.destroy_all

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

  slot = Slot.create!(
    date: Date.today,
    available_quantity: (1..10).to_a.sample,
    time_period: 'unselected',
    product: product
    )

  qty = (1..3).to_a.sample
  status = %w[paid delivered reviewed].sample
  user = User.where(baker: false).sample
  order = Order.create!(
    user: user,
    slot: slot,
    delivery_method: "delivery",
    delivery_address: user.address,
    status: status,
    quantity: qty,
    total: slot.product.price * qty
    )

  rating = (0..5).to_a.sample
  Review.create!(
    rating: rating,
    content: Faker::Lorem.sentence,
    order: order
    )
end

