module ApplicationHelper
  def visited_user
    @visited_user ||= begin
      username = params.fetch(:username)
      User.find_by_username! username
    end
  end
end
