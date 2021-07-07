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
    user1 = create :user
    user2 = create :user
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
      Bond::STATES.each do |state|
        bond.state = state
        expect(bond).to be_valid
      end
    end
  end

  describe "#save" do
    context 'when complete data is given' do
      it 'can be persisted' do
        user = build :user
        friend = build :user
        bond = Bond.new user: user,
                        friend: friend,
                        state: Bond::FOLLOWING
        bond.save
        expect(bond).to be_persisted
        expect(bond.user).to eq user
        expect(bond.friend).to eq friend
      end
    end
  end
end
