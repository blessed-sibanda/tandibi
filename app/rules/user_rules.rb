# frozen_string_literal: true

class UserRules < Bali::Rules
  can :see_timeline do |user, current_user|
    user.is_public? || user == current_user || user.followers.include?(current_user)
  end

  role :admin do
    can :see_timeline
  end

  can :follow do |user, current_user|
    user != current_user &&
      !user.followings.include?(current_user) &&
      !user.inward_bonds.where(
        user: current_user,
        state: Bond::REQUESTING,
      ).exists?
  end

  can :unfollow do |user, current_user|
    user != current_user &&
      current_user.bonds.where(
        friend: user,
        state: [Bond::FOLLOWING, Bond::REQUESTING],
      ).exists?
  end
end
