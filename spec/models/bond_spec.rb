# == Schema Information
#
# Table name: bonds
#
#  id         :bigint           not null, primary key
#  state      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  friend_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_bonds_on_user_id_and_friend_id  (user_id,friend_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (friend_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Bond, type: :model do
  def create_bond
    user1 = User.create!(
      email: "blessed@example.com",
      username: "blessed",
      first_name: "Blessed"
    )
    user2 = User.create!(
      email: "michelle@example.com",
      username: "mishy",
      first_name: "Michelle"
    )
    Bond.create!(
      user_id: user1.id,
      friend_id: user2.id,
      state: Bond::FOLLOWING
    )
  end

  let(:bond) { create_bond }
  describe "#valid?" do
    it "is invalid if state is blank" do
      expect(bond).to be_valid
      bond.state = ""
      expect(bond).not_to be_valid
    end

    it "should validate state correctly" do
      expect(bond).to be_valid
      bond.state = "unknown"
      expect(bond).not_to be_valid

      Bond::STATES.each do |state|
        bond.state = state
        expect(bond).to be_valid
      end
    end
  end
end
