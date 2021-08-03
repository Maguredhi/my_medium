class PagesController < ApplicationController

  def index
    @stories = Story.published_stories
  end

  def show
    
  end

  def user

  end
end
