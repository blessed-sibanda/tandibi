# == Schema Information
#
# Table name: statuses
#
#  id         :bigint           not null, primary key
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Status, type: :model do
  describe "#valid?" do
    it "is invalid if text is blank" do
      status = Status.new(text: "Hello people")
      expect(status).to be_valid
      status.text = ""
      expect(status).not_to be_valid
      status.text = nil
      expect(status).not_to be_valid
    end
  end
end
