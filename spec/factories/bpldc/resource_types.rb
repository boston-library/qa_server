# frozen_string_literal: true

FactoryBot.define do
  factory :bpldc_resource_type, class: 'Bpldc::ResourceType' do
    label { Faker::Book.genre }
    sequence(:id_from_auth) { |n| "marcrelators#{n}" }
    association :authority, factory: :bpldc_authority
    type { 'Curator::ControlledTerms::ResourceType' }
  end
end
