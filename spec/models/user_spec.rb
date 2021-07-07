# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  first_name :string           not null
#  is_public  :boolean          default(TRUE), not null
#  last_name  :string
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  def create_a_user(email: "#{SecureRandom.hex(4)}@example.org")
    User.create!(
      first_name: "Blessed",
      email: email,
      username: SecureRandom.hex(4)
    )
  end

  describe "#valid?" do
    it "is valid when email is unique" do
      user1 = create_a_user
      user2 = create_a_user
      expect(user2.email).not_to be user1.email
      expect(user2).to be_valid
    end

    it "is invalid if the email is taken" do
      create_a_user email: "blessed@example.org"
      user = User.new
      user.email = "blessed@example.org"
      expect(user).not_to be_valid
    end

    it "is invalid if the username is taken" do
      user = create_a_user
      another_user = create_a_user
      expect(another_user).to be_valid
      another_user.username = user.username
      expect(another_user).not_to be_valid
    end

    it "is invalid if the first name is blank" do
      user = create_a_user
      expect(user).to be_valid
      user.first_name = ""
      expect(user).not_to be_valid
      user.first_name = nil
      expect(user).not_to be_valid
    end

    it "is invalid if the username is blank" do
      user = create_a_user
      expect(user).to be_valid
      user.username = ""
      expect(user).not_to be_valid
      user.username = nil
      expect(user).not_to be_valid
    end

    it "is invalid if the email looks bogus" do
      user = create_a_user
      expect(user).to be_valid

      bogus_emails = ["", "foo.bar", "foo.bar#example.com"]
      bogus_emails.each do |email|
        user.email = email
        expect(user).not_to be_valid
      end

      ok_emails = ["f.o.o.b.a.r@example.com",
        "foo+bar@example.com",
        "foo.bar@sub.example.co.id"]
      ok_emails.each do |email|
        user.email = email
        expect(user).to be_valid
      end
    end
  end
end
