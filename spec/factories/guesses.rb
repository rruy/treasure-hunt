FactoryBot.define do
    factory :guess do
      latitude { "-27.4421" }
      longitude { "-48.5062" }
      guessed { false }
      association :user
    end
  end