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
  describe "#valid?" do
    it "is invalid if the activity_type is blank" do
      place = Place.new(locale: "en",
        name: "Wall St.",
        coordinate: "POINT(1 2 3)",
        place_type: "other")
      sight = Sight.new(place: place, activity_type: "check_in")
      expect(sight).to be_valid
      sight.activity_type = ""
      expect(sight).not_to be_valid
    end
  end
end
