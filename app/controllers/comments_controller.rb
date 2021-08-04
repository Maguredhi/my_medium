class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_story, only: [:create]

  def create
    @comment = @story.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      render js: "alert('ok')"
    else
      render js: "alert('error')"
    end
  end

  private

  def find_story
    @story = Story.friendly.find(params[:story_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
