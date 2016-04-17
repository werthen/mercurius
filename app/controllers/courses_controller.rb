class CoursesController < ApplicationController
  def index
    @courses = Course.first(50)
  end

  def show
    @course = Course.find(params[:id])
  end

end
