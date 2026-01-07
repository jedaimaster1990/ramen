# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: "admin@test.com",
  password: "password"
)

users = (1..10).map do |n|
  User.create!(
    name: Faker::Name.name,
    email: "user#{n}@test.com",
    password: "password"
  )
end

address_sample = %w(
  福岡県北九州市
  福岡県朝倉市
  福岡県福岡市
  福岡県春日市
  福岡県筑紫野市
  福岡県久留米市
  福岡県八女市
  福岡県筑後市
  福岡県田川市
  福岡県大野城市
  福岡県太宰府市
  福岡県鳥栖市
)

address_index = 0

users[0..5].each do |user|
  2.times do
    post_image = user.post_images.create!(
      shop_name: Faker::Lorem.word,
      caption: Faker::Lorem.sentence(word_count: rand(5..20)),
      address: address_sample[address_index]
    )
    file_path = Rails.root.join("db/fixtures/images/ramen_image_#{rand(1..7)}.jpg")
    post_image.image.attach(io: File.open(file_path), filename: "ramen_image.jpg", content_type: 'image/jpeg')
    sleep 0.5
    address_index += 1
  end
end

(1..10).each do |n|
  PostComment.create!(
    user_id: rand(1..10),
    post_image_id: rand(1..6),
    comment: Faker::Lorem.word
  )
end
