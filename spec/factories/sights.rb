# == Schema Information
#
# Table name: sights
#
#  id            :bigint           not null, primary key
#  activity_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  place_id      :bigint           not null
#
# Foreign Keys
#
#  fk_rails_...  (place_id => places.id)
#
FactoryBot.define do
  factory :sight do
    place_id { "" }
    activity_type { "MyString" }
  end
end
