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
require "rails_helper"

RSpec.describe Sight, type: :model do
  let(:sight) { build :sight }

  describe "#valid?" do
    it "is invalid if the activity_type is blank" do
      expect(sight).to be_valid
      sight.activity_type = ""
      expect(sight).not_to be_valid
    end
    it "should validate activity_type correctly" do
      expect(sight).to be_valid
      sight.activity_type = "unknown"
      expect(sight).not_to be_valid

      Sight::ACTIVITY_TYPES.each do |type|
        sight.activity_type = type
        expect(sight).to be_valid
      end
    end
  end
end
