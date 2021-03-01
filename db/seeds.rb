require 'nokogiri'

Order.destroy_all
User.destroy_all
Product.destroy_all
Slot.destroy_all

address_list = ['High Park Residences', 'Sky Habitat', 'Villa Marina',
  'City Gate Residences', 'Costa Del Sol', 'The Interlace',
  'Eight Riversuites', 'Kingsford Waterbay', 'The Lakeshore']

baker_bio_list = ['I live to bake', 'I could live on bread alone', 'Bake it til you make it',
  "I'm a pure-bread baker", "Please give me flours on Valentine's day!"]

# good_reviews_list = ['Absolutely yummy', "Second time ordering, I can't get enough!", "Tastes just like my nana's..."]
# average_reviews_list = ['Not too bad, but a little dense', 'It was good, but too sweet and overpowering',
#   'Quality seems a little inconsistent; was better the first time I ordered!']
# bad_reviews_list = ["I'm all about supporting local, but this was really not value for money",
#   "Looks nothing like the picture :(", "Won't be getting this again, unfortunately..."]

bread_url = "https://www.allrecipes.com/search/?wt=bread"
bread_html_file = open(bread_url).read
bread_doc = Nokogiri::HTML(bread_html_file)

cake_url = "https://www.allrecipes.com/search/?wt=cake"
cake_html_file = open(cake_url).read
cake_doc = Nokogiri::HTML(cake_html_file)

results = bread_doc.search(".fixed-recipe-card").first(5).map do |result|
  name = result.search(".fixed-recipe-card__title-link > span").text.strip
  description = result.search(".fixed-recipe-card__description").text.strip
  img = result.search(".fixed-recipe-card__img").attr('data-original-src').value
  [name, description, img]
end

cake_doc.search(".fixed-recipe-card").first(5).map do |result|
  name = result.search(".fixed-recipe-card__title-link > span").text.strip
  description = result.search(".fixed-recipe-card__description").text.strip
  img = result.search(".fixed-recipe-card__img").attr('data-original-src').value
  results << [name, description, img]
end

2.times do
  username = Faker::Internet.username
  user = User.create!(
    name: Faker::Name.name,
    username: username,
    email: "#{username}@gmail.com",
    password: "123456",
    address: "#{address_list.sample}, Singapore",
    baker: false
  )
  user_photo = URI.open('https://source.unsplash.com/200x200/?person')
  user.photo.attach(io: user_photo, filename: "#{user.username}.png", content_type: 'image/png')
end

5.times do
  username = Faker::Internet.username
  baker = User.create!(
    name: Faker::Name.name,
    username: username,
    email: "#{username}@gmail.com",
    password: "123456",
    bio: baker_bio_list.sample,
    address: "#{address_list.sample}, Singapore",
    baker: true
  )
  baker_photo = URI.open('https://source.unsplash.com/200x200/?person')
  baker.photo.attach(io: baker_photo, filename: "#{baker.username}.png", content_type: 'image/png')

  (1..3).to_a.sample.times do
    results_product = results.sample
    product = Product.create!(
      name: results_product[0],
      price: (rand * (5..10).to_a.sample).round(2),
      description: results_product[1],
      user: baker
      )
    product_photo = URI.open(results_product[2])
    product.photo.attach(io: product_photo, filename: "#{product.name}.png", content_type: 'image/png')

    slot = Slot.create!(
      date: Date.today + (2..20).to_a.sample,
      available_quantity: (1..10).to_a.sample,
      product: product
      )

    user = User.where.not(id: baker.id).sample
    basket = Basket.create!(
      user: user,
      )

    qty = (1..3).to_a.sample
    delivered = [true, false].sample
    time_period = %w[morning afternoon evening].sample
    order = Order.create!(
      user: user,
      slot: slot,
      delivery_method: "delivery",
      delivery_address: user.address,
      delivered: true,
      quantity: qty,
      subtotal: slot.product.price * qty,
      time_period:  %w[morning afternoon evening].sample,
      basket: basket
      )

    # rating = (0..5).to_a.sample
    # if rating > 3
    #   content = good_reviews_list.sample
    # elsif rating > 1
    #   content = average_reviews_list.sample
    # else
    #   content = bad_reviews_list.sample
    # end

    # Review.create!(
    #   rating: rating,
    #   content: content,
    #   order: order
    #   )
  end
end
