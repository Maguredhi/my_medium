class PagesController < ApplicationController

  def index
    ## 避免 N+1 問題用 includes 方法，rails 會改用 SQL 的 IN 方法去查詢
    @stories = Story.order(created_at: :desc).includes(:user)
  end

  def show
    
  end

  def user

  end
end
