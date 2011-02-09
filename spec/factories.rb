Factory.define :member do |member|
  member.first_name { Faker::Name.first_name }
  member.last_name { Faker::Name.last_name }
  member.github_username { Faker::Internet.user_name }
  member.twitter_username { Faker::Internet.user_name }
end
