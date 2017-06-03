# Create users
5.times do
    user = User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  
end

users = User.all

# Create Wikis
50.times do
    wiki = Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: false,
    user: users.sample
  )
  wiki.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end

standard = User.create!(
  email: 'standard@blocipedia.com',
  password: 'helloworld'
)


premium = User.create!(
  email: 'premium@blocipedia.com',
  password: 'helloworld'
)


admin = User.create!(
  email: 'admin@blocipedia.com',
  password: 'helloworld'
)


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"