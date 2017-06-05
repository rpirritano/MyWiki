# Create users
5.times do
    user = User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
  
end

users = User.all

# Create wikis using markdown
5.times do
  wiki = Wiki.create!(
    user: users.sample,
    title: Faker::Hipster.sentence(3, true, 2),
    body:
    %Q{### There Is Someething You Should Know!
    This is my very first post using markdown!
    Here is the list of things I wish to do!
    * write more wikis
    * write even more wikis
    * write even more wikis!
    How do you like it? I learned this from [Google](www.google.com)!
    },
    private: Faker::Boolean
  )
  wiki.update_attribute(:created_at, Faker::Time.between(DateTime.now - 365, DateTime.now))
end


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


# Create a admin member
admin = User.create!(
  name: 'admin',
  email: 'premium@example.com',
  password: 'password',
  confirmed_at: Faker::Date.between(1.year.ago, Date.today),
  confirmation_token: Faker::Internet.password(20, 20, true),
  role: 'admin'
)


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"