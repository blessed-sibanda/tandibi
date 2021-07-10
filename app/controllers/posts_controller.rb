class PostsController < ApplicationController
  def create
    is_posted = Post::Creator.call(
      current_user,
      permitted_params
    )
    unless is_posted
      flash[:alert] = 'Something went wrong'
    end
    redirect_to timelines_path
  end

  private
  def permitted_params
    params.require(:post).permit(:postable_type, :status_text)
  end
end
