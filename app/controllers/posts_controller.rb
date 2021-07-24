class PostsController < ApplicationController
  def create
    is_posted = Post::Creator.call(
      current_user,
      permitted_params
    )
    unless is_posted
      flash[:alert] = "Something went wrong"
    end

    redirect_to timelines_path(anchor: "post_#{Post.last.id}")
  end

  private

  def permitted_params
    params.require(:post).permit(:postable_type, :status_text,
      :thread_id, :sight_place_id, pictures: [])
  end
end
