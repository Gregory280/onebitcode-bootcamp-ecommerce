
FactoryBot.define do
  factory :system_requirement do
    sequence(:name) { |n| "Basic #{n}" }
    operational_system { Faker::Computer.os }
    storage { '1 TB' }
    processor { 'Intel i7' }
    memory { '16 GB' }
    video_board { 'N/A' }
  end
end