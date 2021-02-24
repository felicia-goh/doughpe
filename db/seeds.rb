User.destroy_all

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
