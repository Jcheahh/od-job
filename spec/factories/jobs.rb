FactoryBot.define do
  factory :job do
    title { Faker::Lorem.word }
    description { Faker::Lorem.word }
    pick_up_address { Faker::Address.full_address }
    pick_up_latitude { Faker::Address.latitude }
    pick_up_longitude { Faker::Address.longitude }
    drop_off_address { Faker::Address.full_address }
    drop_off_latitude { Faker::Address.latitude }
    drop_off_longitude { Faker::Address.longitude }
  end
end
