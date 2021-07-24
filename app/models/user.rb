# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  is_public              :boolean          default(TRUE), not null
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :confirmable, :trackable,
    authentication_keys: [:login],
    reset_password_keys: [:login]
  before_save :ensure_proper_name_case

  attr_writer :login

  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :first_name, presence: true
  validates :username, presence: true
  validates :email, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: "must be a valid email address"
  }

  has_many :posts
  has_many :bonds
  has_many :inward_bonds,
    class_name: "Bond",
    foreign_key: :friend_id
  has_many :followings,
    -> { Bond.following },
    through: :bonds,
    source: :friend
  has_many :follow_requests,
    -> { Bond.requesting },
    through: :bonds,
    source: :friend
  has_many :followers,
    -> { Bond.following },
    through: :inward_bonds,
    source: :user

  def to_param
    username
  end

  def login
    @login || username || email
  end

  class << self
    def find_authenticatable(login)
      where("username = :value OR email = :value", value: login).first
    end

    def find_for_database_authentication(conditions)
      conditions = conditions.dup
      login = conditions.delete(:login).downcase
      find_authenticatable(login)
    end

    def find_recoverable_or_init_with_errors(conditions)
      conditions = conditions.dup
      login = conditions.delete(:login).downcase
      recoverable = find_authenticatable(login)
      unless recoverable
        recoverable = new(login: login)
        recoverable.errors.add(:login, login.present? ? :not_found : :blank)
      end
      recoverable
    end

    def send_reset_password_instructions(conditions)
      recoverable = find_recoverable_or_init_with_errors(conditions)
      if recoverable.persisted?
        recoverable.send_reset_password_instructions
      end
      recoverable
    end
  end

  private

  def ensure_proper_name_case
    first_name.capitalize!
  end
end
