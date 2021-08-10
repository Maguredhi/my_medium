class Api::StoriesController < Api::BaseController
  # 注意 expect預計 與 except除了 的差異
  # before_action :authenticate_user!, except: [:clap]

  def clap
    story = Story.friendly.find(params[:id])
    # 用 increment! 方法直接對 table 欄位加1
    story.increment!(:clap)
    render json: {status: story.clap}
  end

end
