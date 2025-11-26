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

(1..10).each do |n|
  User.create!(
    name: Faker::Name.name,
    email: "user#{n}@test.com",
    password: "password"
  )
end

(1..10).each do |n|
  PostComment.create!(
    name: Faker::Name.name,
    post_comment: Faker::Lorem.word
  )
end

(1..6).each do |n|
  rand(1..3).times do
    post_image = PostImage.create!(
      user_id: n,
      shop_name: Faker::Lorem.word,
      caption: Faker::Lorem.sentence(word_count: rand(5..20))
    )
    file_path = Rails.root.join("db/fixtures/images/ramen_image_#{rand(1..5)}.jpg")
    post_image.image.attach(io: File.open(file_path), filename: "ramen_image.jpg", content_type: 'image/jpeg')
    sleep 0.5
  end
end