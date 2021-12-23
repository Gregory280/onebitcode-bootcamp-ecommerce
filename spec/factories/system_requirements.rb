FactoryBot.define do
  factory :system_requirement do
    sequence(:name) { |n| "Basic #{n}" }
    operational_system { Faker::Computer.os }
    storage { Samples::SystemRequirements.storage }
    processor { Samples::SystemRequirements.processor }
    memory { Samples::SystemRequirements.memory }
    video_board { Samples::SystemRequirements.video_board }
  end
end