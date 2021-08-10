class Api::StoriesController < Api::BaseController
  # 注意 expect預計 與 except除了 的差異
  # before_action :authenticate_user!, except: [:clap]
  before_action :find_story

  def clap
    # 用 increment! 方法直接對 table 欄位加1
    story.increment!(:clap)
    render json: {status: @story.clap}
  end

  def bookmark
    render json: {status: current_user.bookmark!(@story)}
  end

  private

  def find_story
    @story = Story.friendly.find(params[:id])
  end
  
end
