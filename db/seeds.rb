require 'random_data'


 # Create Wikis
 50.times do
     Wiki.create!(
         @wiki.user.email
         title:  RandomData.random_sentence,
         body:   RandomData.random_paragraph
         )
        end

 wikis = Wiki.all





 puts "Seed finished"
 puts "#{Wiki.count} wikis created"

