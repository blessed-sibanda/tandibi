# == Schema Information
#
# Table name: places
#
#  id         :bigint           not null, primary key
#  coordinate :geography        not null, point, 4326
#  locale     :string           not null
#  name       :string           not null
#  place_type :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_places_on_coordinate             (coordinate) USING gist
#  index_places_on_locale                 (locale)
#  index_places_on_locale_and_coordinate  (locale,coordinate) UNIQUE
#
require "rails_helper"

RSpec.describe Place, type: :model do
  let(:place) { build :place }

  describe "#valid?" do
    it "is invalid if locale is blank" do
      expect(place).to be_valid
      place.locale = ""
      expect(place).not_to be_valid
      place.locale = nil
      expect(place).not_to be_valid
    end
    it "is invalid if coordinate is blank" do
      expect(place).to be_valid
      place.coordinate = ""
      expect(place).not_to be_valid
      place.coordinate = nil
      expect(place).not_to be_valid
    end
    it "is invalid if name is blank" do
      expect(place).to be_valid
      place.name = ""
      expect(place).not_to be_valid
      place.name = nil
      expect(place).not_to be_valid
    end
    it "is invalid if place_type is blank" do
      expect(place).to be_valid
      place.place_type = ""
      expect(place).not_to be_valid
      place.place_type = nil
      expect(place).not_to be_valid
    end
    it "should validate place_type correctly" do
      expect(place).to be_valid
      place.place_type = "unknown"
      expect(place).not_to be_valid

      Place::PLACE_TYPES.each do |type|
        place.place_type = type
        expect(place).to be_valid
      end
    end
  end
end
