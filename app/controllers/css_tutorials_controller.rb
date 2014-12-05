class CssTutorialsController < ApplicationController
  def index
  end

  def new
  end

  def create
    css_tutorial_attr = params
      .require(:css_tutorial)
      .permit(:title, :tid, :html, :css, :check_data, :tips_data)
    CssTutorial.create!(css_tutorial_attr)
    redirect_to :action => :index
  end
end
