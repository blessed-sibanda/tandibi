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
  describe "#valid?" do
    it "is invalid if state is blank" do
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
      bond = Bond.create!(
        user_id: user1.id,
        friend_id: user2.id,
        state: "following"
      )
      expect(bond).to be_valid
      bond.state = ""
      expect(bond).not_to be_valid
    end
  end
end
