class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_story, only: [:edit, :update, :destroy]

  def index
    @stories = current_user.stories.order(created_at: :desc)
  end

  def new
    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.new(story_params)
    # @story.status = 'published' if params[:publish]
    @story.publish! if params[:publish]

    if @story.save
      if params[:publish]
        redirect_to stories_path, notice: 'Story Published Success!'
      else
        redirect_to edit_story_path(@story), notice: 'Draft Save!'
      end
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @story.update(story_params)
      case
      when params[:publish] 
        @story.publish!
        redirect_to stories_path, notice: 'Story Published Success!'
      when params[:unpublish]
        @story.unpublish!
        redirect_to stories_path, notice: 'Story Unpublished Success!'
      else
        redirect_to edit_story_path(@story), notice: 'Edit Success!'
      end
    else
      render :edit
    end
  end

  def destroy
    @story.destroy
    redirect_to stories_path, notice: 'Story Destroy Success!'
  end

  private
  def find_story
    @story = current_user.stories.friendly.find(params[:id])
  end
  
  def story_params
    params.require(:story).permit(:title, :content, :cover_image)
  end

end
