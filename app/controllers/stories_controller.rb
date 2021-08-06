class StoriesController < ApplicationController
  # 注意 expect預計 與 except除了 的差異
  before_action :authenticate_user!, except: [:clap]
  before_action :find_story, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:clap]

  def index
    @stories = current_user.stories.order(created_at: :desc)
  end

  def new
    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.new(story_params)
    # @story.status = 'published' if params[:publish]
    # 改用 AASM 狀態機來 create
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

  def clap
    if user_signed_in?
      story = Story.friendly.find(params[:id])
      # 用 increment! 方法直接對 table 欄位加1
      story.increment!(:clap)
      render json: {status: story.clap}
    else
      render json: {status: "sign_in_first"}
    end
  end

  private
  def find_story
    @story = current_user.stories.friendly.find(params[:id])
  end
  
  def story_params
    params.require(:story).permit(:title, :content, :cover_image)
  end

end
