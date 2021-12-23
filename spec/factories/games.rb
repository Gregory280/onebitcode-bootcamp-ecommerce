FactoryBot.define do
  factory :game do
    mode { [:pvp, :pve, :both].sample }
    release_date { "2021-12-22 17:38:05" }
    developer { Faker::Company.name }
    system_requirement
  end
end
