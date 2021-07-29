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
    if @story.save
      redirect_to stories_path, notice: 'Create Success!'
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @story.update(story_params)
      redirect_to stories_path, notice: 'Story Edit Success!'
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
    @story = current_user.stories.find(params[:id])
  end
  
  def story_params
    params.require(:story).permit(:title, :content)
  end
  
end
