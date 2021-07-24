# frozen_string_literal: true

module SightDecorator
  def humanized_activity_type
    case activity_type
    when Sight::CHECKIN
      "checked in at"
    when Sight::CHECKOUT
      "checked out from"
    end
  end
end
